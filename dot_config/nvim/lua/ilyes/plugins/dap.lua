-- auto_toggle opens/closes the view with every session, including neotest's dap strategy.
require('dap-view').setup {
  auto_toggle = true,
  winbar = {
    sections = { 'scopes', 'watches', 'exceptions', 'breakpoints', 'threads', 'repl' },
    default_section = 'scopes',
  },
  -- windows = {
  --   position = 'bottom',
  --   size = 0.35,
  --   -- Stack the terminal under the panel instead of beside it.
  --   terminal = { position = 'below' },
  -- },
}

-- Jump to the window already showing the source file instead of replacing the current (test) window.
require('dap').defaults.fallback.switchbuf = 'useopen,uselast'

-- Language drivers
require('dap-python').setup()
require('dap-go').setup()

-- nvim-dap defaults all signs to SignColumn letters; use our icons and a group each.
local icons = require('ilyes.core.icons').dap
local signs = {
  DapBreakpoint = icons.breakpoint,
  DapBreakpointCondition = icons.conditional,
  DapBreakpointRejected = icons.rejected,
  DapLogPoint = icons.log,
  DapStopped = icons.stopped,
}
for name, text in pairs(signs) do
  vim.fn.sign_define(name, { text = text, texthl = name, linehl = name == 'DapStopped' and 'debugPC' or '' })
end
