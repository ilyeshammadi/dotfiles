return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
    },
    event = 'VeryLazy',
    config = function()
      require('neotest').setup {
        quickfix = {
          open = false,
        },
        output = {
          enabled = true,
          open_on_run = false,
        },
        adapters = {
          require 'neotest-python' {
            -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
            dap = {
              justMyCode = false,
            },
            args = { '--log-level', 'DEBUG', '-vvv', '-p', 'no:warnings' },
            runner = 'pytest',
            python = '.venv/bin/python',
          },
        },
      }
    end,
  },
}
