return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('codecompanion').setup {
      strategies = {
        chat = {
          adapter = 'qwen',
        },
        inline = {
          adapter = 'qwen',
        },
        cmd = {
          adapter = 'qwen',
        },
      },
      adapters = {
        qwen = function()
          return require('codecompanion.adapters').extend('ollama', {
            name = 'qwen',
            schema = {
              model = {
                default = 'qwen2.5-coder:7b',
              },
            },
          })
        end,
        deepseek = function()
          return require('codecompanion.adapters').extend('ollama', {
            name = 'deepseek',
            schema = {
              model = {
                default = 'deepseek-r1:8b',
              },
            },
          })
        end,
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
