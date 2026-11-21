-- Hover split: `K` shows LSP docs in a bottom split that closes when the
-- cursor moves; `gK` keeps it open. Every press reuses the same split.
local hover_win
local hover_group = vim.api.nvim_create_augroup('ilyes-hover-split', { clear = true })
local hover_max_height = 25

local function hover_split(pin)
  -- Each server can use a different column encoding, so build params per client.
  local params = function(client)
    return vim.lsp.util.make_position_params(0, client.offset_encoding)
  end

  vim.lsp.buf_request_all(0, 'textDocument/hover', params, function(results)
    local lines = {}
    for _, res in pairs(results) do
      if res.result then
        lines = vim.lsp.util.convert_input_to_markdown_lines(res.result.contents)
        break
      end
    end
    -- Same cleanup the hover float does: trim/collapse blank lines, draw `---` as a rule.
    lines = vim.lsp.util._normalize_markdown(lines, { width = vim.o.columns })
    if #lines == 0 then
      return vim.notify 'No hover info'
    end

    -- Fresh scratch buffer per hover; `bufhidden=wipe` deletes it once replaced or closed.
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].filetype, vim.bo[buf].bufhidden, vim.bo[buf].modifiable = 'markdown', 'wipe', false
    vim.treesitter.start(buf, 'markdown') -- highlights code blocks like the float

    if hover_win and vim.api.nvim_win_is_valid(hover_win) then
      vim.api.nvim_win_set_buf(hover_win, buf)
    else -- full-width split at the bottom, cursor stays in the code
      hover_win = vim.api.nvim_open_win(buf, false, { split = 'below', win = -1 })
    end
    local wo = vim.wo[hover_win] -- hover float's options: hide ``` fences, wrap nicely
    wo.conceallevel, wo.concealcursor = 2, 'nc'
    wo.wrap, wo.linebreak, wo.breakindent, wo.smoothscroll = true, true, true, true
    wo.foldenable, wo.number, wo.relativenumber, wo.signcolumn = false, false, false, 'no'
    wo.winfixheight = true -- tmux/terminal resizes don't grow the split
    local h = vim.api.nvim_win_text_height(hover_win, { max_height = hover_max_height }).all
    vim.api.nvim_win_set_height(hover_win, math.max(h, 1))

    -- Drop any pending auto-close, then arm a one-shot one unless pinned.
    vim.api.nvim_clear_autocmds { group = hover_group }
    if not pin then
      vim.api.nvim_create_autocmd('CursorMoved', {
        group = hover_group,
        callback = function()
          if vim.api.nvim_get_current_win() == hover_win then
            return -- scrolling inside the docs keeps them open
          end
          if vim.api.nvim_win_is_valid(hover_win) then
            vim.api.nvim_win_close(hover_win, false)
          end
          return true
        end,
      })
    end
  end)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('ilyes-lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    vim.keymap.set('n', 'K', function()
      hover_split(false)
    end, { buffer = event.buf, desc = 'LSP hover docs' })
    vim.keymap.set('n', 'gK', function()
      hover_split(true)
    end, { buffer = event.buf, desc = 'LSP Hover docs (pinned)' })

    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('ilyes-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('ilyes-lsp-detach', { clear = true }),
        buffer = event.buf,
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'ilyes-lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})

local servers = {
  basedpyright = {
    -- venvPath is cwd-relative and needs `venv` too; point at the project's interpreter instead.
    before_init = function(_, config)
      local python = config.root_dir and config.root_dir .. '/.venv/bin/python'
      if python and vim.uv.fs_stat(python) then
        config.settings.python.pythonPath = python
      end
    end,
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = 'basic',
        },
      },
      python = {},
    },
  },
  gopls = {
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  emmylua_ls = {
    on_init = function(client)
      -- Defer to a project's own Lua LSP config when it has one.
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.emmyrc.json') or vim.uv.fs_stat(path .. '/.luarc.json')) then
          client.config.settings = {}
        end
        -- Editing the chezmoi source: the root is the repo, so point requires at the nvim dir.
        local chezmoi_nvim = path .. '/dot_config/nvim'
        if vim.uv.fs_stat(chezmoi_nvim) then
          client.config.settings.emmylua.workspace.workspaceRoots = { chezmoi_nvim }
        end
      end
    end,
    settings = {
      emmylua = {
        runtime = {
          version = 'LuaJIT',
          -- `lua/` entries so `require 'ilyes.plugins.x'` resolves.
          requirePattern = { '?.lua', '?/init.lua', 'lua/?.lua', 'lua/?/init.lua' },
        },
        diagnostics = { globals = { 'vim' } },
        hint = { enable = true },
        -- Whole runtimepath so loaded plugins (blink.cmp etc.) resolve too.
        workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      },
    },
  },
  ts_ls = {},
  typos_lsp = {},
  yamlls = {},

  -- Self-contained: no nvim-lspconfig default needed for these three.
  helm_ls = {
    cmd = { 'helm_ls', 'serve' },
    filetypes = { 'helm', 'yaml.helm-values' },
    root_markers = { 'Chart.yaml' },
    capabilities = {
      workspace = { didChangeWatchedFiles = { dynamicRegistration = true } },
    },
    settings = {
      ['helm-ls'] = {
        yamlls = {
          path = 'yaml-language-server',
        },
      },
    },
  },
  terraformls = {
    cmd = { 'terraform-ls', 'serve' },
    filetypes = { 'terraform', 'terraform-vars' },
    root_markers = { '.terraform', '.git' },
    on_attach = function(_, bufnr)
      vim.lsp.codelens.enable(true, { bufnr = bufnr })
    end,
  },
  nil_ls = {
    cmd = { 'nil' },
    filetypes = { 'nix' },
    root_markers = { 'flake.nix', '.git' },
  },

  clangd = {},
}

-- `'*'` merges into every named config.
vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })
for name, server in pairs(servers) do
  vim.lsp.config(name, server)
end
vim.lsp.enable(vim.tbl_keys(servers))

vim.diagnostic.config {
  signs = {
    -- Blank: severity shows through numhl and underline instead.
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
  },
  virtual_text = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = 'minimal',
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },
}
