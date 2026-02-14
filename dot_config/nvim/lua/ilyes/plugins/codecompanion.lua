return {
  'olimorris/codecompanion.nvim',
  event = 'VeryLazy',
  version = '^18.0.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('codecompanion').setup {
      interactions = {
        chat = {
          adapter = {
            name = 'claude_code',
            model = 'haiku',
          },
        },
        inline = {
          adapter = 'claude_code',
          model = 'sonnet',
        },
        cmd = {
          adapter = 'claude_code',
          model = 'sonnet',
        },
      },
      adapters = {
        acp = {
          claude_code = function()
            return require('codecompanion.adapters').extend('claude_code', {
              env = {
                CLAUDE_CODE_OAUTH_TOKEN = 'cmd:cat ~/.config/secrets/anthropic_key',
              },
            })
          end,
        },
      },
      opts = {
        log_level = 'DEBUG',
      },
      display = {
        diff = {
          enabled = true,
          provider = 'mini_diff',
        },
      },
    }

    vim.api.nvim_set_keymap('n', '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })

    vim.api.nvim_set_keymap('n', '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd [[cab cc CodeCompanion]]
    vim.cmd [[cab ccc CodeCompanionCmd]]
  end,
}
