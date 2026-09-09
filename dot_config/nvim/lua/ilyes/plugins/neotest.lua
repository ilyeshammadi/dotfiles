require('neotest').setup {
  quickfix = {
    open = false,
  },
  output = {
    enabled = true,
    open_on_run = false,
  },
  adapters = {
    require 'neotest-go',
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
