return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
  config = function()
    local wk = require 'which-key'
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
          require('which-key').show { global = false }
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
      { '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', desc = 'Code action' },
      { '<leader>lf', "<cmd>lua require('conform').format()<CR>", desc = 'Format' },
      { '<leader>li', '<cmd>LspInfo<CR>', desc = 'Info' },
      { '<leader>ll', '<cmd>lua vim.lsp.codelens.run()<CR>', desc = 'CodeLens action' },
      { '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', desc = 'Quickfix' },
      { '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', desc = 'Rename' },
      { '<leader>s', group = 'Search' },
      { '<leader>t', group = 'Test' },
      { '<leader>tO', "<cmd>lua require('neotest').output_panel.toggle()<CR>", desc = 'Output Panel' },
      { '<leader>tT', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", desc = 'Run DAP' },
      { '<leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', desc = 'Run File' },
      { '<leader>to', "<cmd>lua require('neotest').output.open({enter = true})<CR>", desc = 'Output' },
      { '<leader>ts', "<cmd>lua require('neotest').summary.toggle()<CR>", desc = 'Summary' },
      { '<leader>tt', "<cmd>lua require('neotest').run.run()<CR>", desc = 'Run' },
      { '<leader>u', group = 'Toggle' },
    }
  end,
}
