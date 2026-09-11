-- Before any server is enabled, to get mason's bin on $PATH.
require('mason').setup {}
require('fidget').setup {}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('ilyes-lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
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
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = 'basic',
        },
        python = {
          venvPath = './venv',
        },
      },
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
        -- Swap for `vim.api.nvim_get_runtime_file('', true)` to index every
        -- installed plugin too. Slower.
        workspace = { library = { vim.env.VIMRUNTIME } },
      },
    },
  },
  yamlls = {},
  helm_ls = {
    settings = {
      ['helm-ls'] = {
        yamlls = {
          path = 'yaml-language-server',
        },
      },
    },
  },
  terraformls = {},
  -- nix lsp
  nil_ls = {},
}

require('mason-tool-installer').setup {
  ensure_installed = {
    'basedpyright',
    'gopls',
    'gofumpt',
    'delve',
    'emmylua_ls',
    'stylua',
    'prettier',
    'sqlfluff',
    'djlint',
    'helm-ls',
    'yaml-language-server',
    'terraform-ls',
    'nil',
  },
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
  virtual_text = false,
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
