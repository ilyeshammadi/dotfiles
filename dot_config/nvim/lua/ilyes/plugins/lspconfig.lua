local icons = require 'ilyes.core.icons'

local default_diagnostic_config = {
  signs = {
    active = true,
  },
  virtual_text = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  lazy = true,
  event = 'VeryLazy',
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = {
      -- Python
      basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = 'basic',
            },
          },
        },
      },
      ruff = {},
      -- Go
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
      -- Lua
      lua_ls = {
        settings = {
          Lua = {
            hint = { enable = true },
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
            },
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      },
      -- Html
      emmet_ls = {},
      jinja_lsp = {},
			htmx_lsp = {},
      -- Markdown
      marksman = {},
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'prettier',
      'stylua',
      'sqlfluff',
      'beautysh',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = {
      Error = icons.diagnostics.BoldError,
      Warn = icons.diagnostics.BoldWarning,
      Hint = icons.diagnostics.BoldHint,
      Info = icons.diagnostics.BoldInformation,
    }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    -- Apply default diagnostic config
    vim.diagnostic.config(default_diagnostic_config)

    -- Set borders
    local function set_handler_opts_if_not_set(name, handler, opts)
      if debug.getinfo(vim.lsp.handlers[name], 'S').source:find(vim.env.VIMRUNTIME, 1, true) then
        vim.lsp.handlers[name] = vim.lsp.with(handler, opts)
      end
    end

    set_handler_opts_if_not_set('textDocument/hover', vim.lsp.handlers.hover, { border = 'rounded' })
    set_handler_opts_if_not_set('textDocument/signatureHelp', vim.lsp.handlers.signature_help, { border = 'rounded' })
    require('lspconfig.ui.windows').default_options.border = 'rounded'
  end,
}
