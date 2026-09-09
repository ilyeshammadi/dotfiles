-- TODO: Setup debugging

local dap = require 'dap'
local dapui = require 'dapui'

require('mason-nvim-dap').setup {
  automatic_setup = true,
  handlers = {},
  ensure_installed = {},
}

dapui.setup {}
require('nvim-dap-virtual-text').setup()

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

-- Language drivers
require('dap-python').setup()
require('dap-go').setup()
