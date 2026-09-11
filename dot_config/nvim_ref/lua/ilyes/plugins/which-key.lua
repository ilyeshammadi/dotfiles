local wk = require 'which-key'

-- NOTE: lazy skips the automatic `setup(opts)` when a `config` function is
-- given, and the old config function never called it -- so these options were
-- silently dead. They apply now, so which-key looks different. Delete to revert.
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
    mappings = false,
  },
}

wk.add {
  {
    '<leader>?',
    function()
      wk.show { global = false }
    end,
    desc = 'Buffer Local Keymaps (which-key)',
  },
  { '<leader>d', group = 'Debug' },
  { '<leader>dC', "<cmd>lua require'dap'.run_to_cursor()<CR>", desc = 'Run To Cursor' },
  { '<leader>dT', "<cmd>lua require'dap'.toggle_breakpoint(vim.fn.input('Breakpoint with condition: '))<CR>", desc = 'Toggle conditional breakpoint' },
  { '<leader>dU', "<cmd>lua require'dapui'.toggle({reset = true})<CR>", desc = 'Toggle UI' },
  { '<leader>dc', "<cmd>lua require'dap'.continue()<CR>", desc = 'Continue' },
  { '<leader>dd', "<cmd>lua require'dap'.disconnect()<CR>", desc = 'Disconnect' },
  { '<leader>dg', "<cmd>lua require'dap'.session()<CR>", desc = 'Get Session' },
  { '<leader>di', "<cmd>lua require'dap'.step_into()<CR>", desc = 'Step Into' },
  { '<leader>do', "<cmd>lua require'dap'.step_over()<CR>", desc = 'Step Over' },
  { '<leader>dp', "<cmd>lua require'dap'.pause()<CR>", desc = 'Pause' },
  { '<leader>dq', "<cmd>lua require'dap'.close()<CR>", desc = 'Quit' },
  { '<leader>dr', "<cmd>lua require'dap'.repl.toggle()<CR>", desc = 'Toggle Repl' },
  { '<leader>ds', "<cmd>lua require'dap'.continue()<CR>", desc = 'Start' },
  { '<leader>dt', "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = 'Toggle breakpoint' },
  { '<leader>du', "<cmd>lua require'dap'.step_out()<CR>", desc = 'Step Out' },
  { '<leader>g', group = 'Git' },
  { '<leader>l', group = 'Lsp' },
  { '<leader>lR', '<cmd>LspRestart<CR>', desc = 'Restart LSP' },
  { '<leader>lf', "<cmd>lua require('conform').format()<CR>", desc = 'Format' },
  { '<leader>li', '<cmd>LspInfo<CR>', desc = 'Info' },
  { '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', desc = 'Quickfix' },
  { '<leader>s', group = 'Search' },
  { '<leader>u', group = 'Toggle' },
  { '<leader>o', group = 'Obsidian' },
  { '<leader>os', '<cmd>Obsidian search<CR>', desc = 'Search' },
  { '<leader>oc', '<cmd>Obsidian new<CR>', desc = 'Create' },
  { '<leader>ot', '<cmd>Obsidian tags<CR>', desc = 'Tags' },
  { '<leader>od', '<cmd>Obsidian dailies<CR>', desc = 'Dailies' },
  { '<leader>ow', '<cmd>Obsidian workspace<CR>', desc = 'Workspace' },
}
