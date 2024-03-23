return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-python',
      'nvim-neotest/nvim-nio',
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
            args = { '--log-level', 'DEBUG', '-vvv' },
            runner = 'pytest',
            python = '.venv/bin/python',
          },
        },
      }
    end,
  },
}
