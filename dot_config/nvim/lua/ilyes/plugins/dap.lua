local dap = require 'dap'
local dapui = require 'dapui'

dapui.setup {}

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

-- Language drivers
require('dap-python').setup()
require('dap-go').setup()
