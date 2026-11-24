-- Hover at the bottom: Neovim's own hover float, moved to the bottom of the
-- screen (full width, drawn over the code). Only `vim.lsp.buf.hover` passes
-- focus_id 'textDocument/hover', so every other float is left untouched.
local open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts)
  local buf, win = open_floating_preview(contents, syntax, opts)
  if opts and opts.focus_id == 'textDocument/hover' then
    local row = vim.o.lines - vim.o.cmdheight - 1 -- just above the global statusline
    vim.api.nvim_win_set_config(win, {
      relative = 'editor',
      anchor = 'SW',
      row = row,
      col = 0,
      width = vim.o.columns,
    })
    -- Width changed, so re-fit the height to the wrapped text.
    vim.api.nvim_win_set_height(win, vim.api.nvim_win_text_height(win, { max_height = 20 }).all)
  end
  return buf, win
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('ilyes-lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = event.buf, desc = 'LSP hover docs' })
    vim.keymap.set('n', 'gK', function()
      -- Stays open (`q` inside closes it); `focus = false` replaces an
      -- open one instead of jumping into it.
      vim.lsp.buf.hover { close_events = {}, focus = false }
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
  yamlls = {
    settings = {
      yaml = {
        schemas = {
          kubernetes = { 'k8s/**/*.yaml', '*.k8s.yaml' }, -- adjust globs to your manifests
        },
      },
    },
  },

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
