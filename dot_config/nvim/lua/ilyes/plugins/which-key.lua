local wk = require 'which-key'
local icons = require 'ilyes.core.icons'

wk.setup {
  preset = 'modern',
  delay = function(ctx)
    return ctx.plugin and 0 or 500
  end,
  win = {
    border = 'single',
  },
  plugins = {
    presets = {
      operators = false,
      motions = false,
      text_objects = true,
      z = false,
    },
  },
  icons = {
    -- Only the explicit per-mapping icons; no rule-based ones.
    rules = false,
  },
}

wk.add {
  {
    '<leader>?',
    function()
      wk.show { global = false }
    end,
    desc = 'Buffer Local Keymaps',
    icon = icons.help,
  },
  { '<leader>d', group = 'Debug', icon = icons.group.debug },
  { '<leader>dC', "<cmd>lua require'dap'.run_to_cursor()<CR>", desc = 'Run To Cursor', icon = icons.debug.run_to_cursor },
  {
    '<leader>dB',
    "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    desc = 'Conditional breakpoint',
    icon = icons.debug.conditional,
  },
  { '<leader>db', "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = 'Toggle breakpoint', icon = icons.debug.breakpoint },
  { '<leader>dc', "<cmd>lua require'dap'.continue()<CR>", desc = 'Continue', icon = icons.debug.continue },
  { '<leader>de', '<cmd>DapViewHover<CR>', desc = 'Hover', mode = { 'n', 'v' }, icon = icons.debug.hover },
  { '<leader>di', "<cmd>lua require'dap'.step_into()<CR>", desc = 'Step Into', icon = icons.debug.step_into },
  { '<leader>dl', "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log message: '))<CR>", desc = 'Log point', icon = icons.debug.log },
  { '<leader>dn', "<cmd>lua require'dap'.step_over()<CR>", desc = 'Step Over', icon = icons.debug.step_over },
  { '<leader>do', "<cmd>lua require'dap'.step_out()<CR>", desc = 'Step Out', icon = icons.debug.step_out },
  { '<leader>dr', "<cmd>lua require'dap'.run_last()<CR>", desc = 'Run Last', icon = icons.debug.run_last },
  { '<leader>du', '<cmd>DapViewToggle<CR>', desc = 'Toggle UI', icon = icons.debug.ui },
  { '<leader>dw', '<cmd>DapViewWatch<CR>', desc = 'Watch', mode = { 'n', 'v' }, icon = icons.debug.watch },
  { '<leader>dx', "<cmd>lua require'dap'.terminate()<CR>", desc = 'Terminate', icon = icons.debug.terminate },
  { '<leader>g', group = 'Git', icon = icons.group.git },
  { '<leader>l', group = 'Lsp', icon = icons.group.lsp },
  { '<leader>lR', '<cmd>LspRestart<CR>', desc = 'Restart LSP', icon = icons.lsp.restart },
  { '<leader>lf', "<cmd>lua require('conform').format()<CR>", desc = 'Format', icon = icons.lsp.format },
  { '<leader>li', '<cmd>LspInfo<CR>', desc = 'Info', icon = icons.lsp.info },
  { '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', desc = 'Quickfix', icon = icons.lsp.quickfix },
  { '<leader>s', group = 'Search', icon = icons.group.search },
  { '<leader>t', group = 'Test', icon = icons.group.test },
  { '<leader>tO', "<cmd>lua require('neotest').output_panel.toggle()<CR>", desc = 'Output Panel', icon = icons.test.output_panel },
  { '<leader>tT', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", desc = 'Run DAP', icon = icons.test.run_dap },
  { '<leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', desc = 'Run File', icon = icons.test.run_file },
  { '<leader>to', "<cmd>lua require('neotest').output.open({enter = true})<CR>", desc = 'Output', icon = icons.test.output },
  { '<leader>ts', "<cmd>lua require('neotest').summary.toggle()<CR>", desc = 'Summary', icon = icons.test.summary },
  { '<leader>tt', "<cmd>lua require('neotest').run.run()<CR>", desc = 'Run', icon = icons.test.run },
  { '<leader>u', group = 'Toggle', icon = icons.group.toggle },
  { '<leader>o', group = 'Obsidian', icon = icons.group.obsidian },
  { '<leader>os', '<cmd>Obsidian search<CR>', desc = 'Search', icon = icons.obsidian.search },
  { '<leader>oc', '<cmd>Obsidian new<CR>', desc = 'Create', icon = icons.obsidian.create },
  { '<leader>ot', '<cmd>Obsidian tags<CR>', desc = 'Tags', icon = icons.obsidian.tags },
  { '<leader>od', '<cmd>Obsidian dailies<CR>', desc = 'Dailies', icon = icons.obsidian.dailies },
  { '<leader>ow', '<cmd>Obsidian workspace<CR>', desc = 'Workspace', icon = icons.obsidian.workspace },
}
