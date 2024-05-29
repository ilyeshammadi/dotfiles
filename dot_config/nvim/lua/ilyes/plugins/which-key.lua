return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    local prefix = '<leader>'
    local wk = require 'which-key'

    vim.o.timeout = true
    vim.o.timeoutlen = 700

    wk.setup {
      window = {
        border = 'single',
        winblend = 0,
      },
      layout = {
        align = 'center',
      },
      plugins = {
        presets = {
          operators = false,
          motions = false,
          text_objects = true,
        },
      },
      triggers_nowait = {
        -- marks
        '`',
        'g`',
        "g'",
        -- registers
        '"',
        '<c-r>',
        -- spelling
        'z=',
      },
    }

    -- Document existing key chains
    wk.register({
      s = {
        name = 'Search',
        f = { '<cmd>lua require("telescope.builtin").find_files({ hidden = true })<CR>', 'Files' },
        g = { [[:lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]], 'Grep' },
        G = {
          [[:lua require("telescope-live-grep-args.shortcuts").grep_word_under_cursor({ postfix = " -F --hidden"})<CR>]],
          'Grep word under cursor',
        },
        r = { '<cmd>lua require("telescope.builtin").oldfiles()<CR>', 'Recent Files' },
        l = { '<cmd>lua require("telescope.builtin").resume()<CR>', 'Resume' },
        n = {
          '<cmd>lua require("telescope.builtin").find_files({cwd = vim.fn.stdpath("config")})<CR>',
          'Neovim files',
        },
      },
      g = {
        name = 'Git',
        l = { "<cmd>lua require 'gitsigns'.blame_line()<CR>", 'Blame' },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", 'Preview hunk' },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", 'Reset hunk' },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", 'Reset buffer' },
        o = { '<cmd>Telescope git_status<CR>', 'Open changed file' },
      },
      l = {
        name = 'Lsp',
        t = {
          function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
          end,
          'Toggle inlay hints',
        },
        a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'Code action' },
        f = { "<cmd>lua require('conform').format()<CR>", 'Format' },
        l = { '<cmd>lua vim.lsp.codelens.run()<CR>', 'CodeLens action' },
        q = { '<cmd>lua vim.diagnostic.setloclist()<CR>', 'Quickfix' },
        r = { '<cmd>lua vim.lsp.buf.rename()<CR>', 'Rename' },
        R = { '<cmd>LspRestart<CR>', 'Restart LSP' },
        x = {
          name = 'Extra',
          e = {
            '<cmd>lua vim.diagnostic.config({virtual_text = true, signs = true})<CR>',
            'Enable diagnostic',
          },
          d = {
            '<cmd>lua vim.diagnostic.config({virtual_text = false, signs = true})<CR>',
            'Disable diagnostic',
          },
        },
        i = { '<cmd>LspInfo<CR>', 'Info' },
      },
      d = {
        name = 'Debug',
        t = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", 'Toggle breakpoint' },
        T = {
          "<cmd>lua require'dap'.toggle_breakpoint(vim.fn.input('Breakpoint with condition: '))<CR>",
          'Toggle conditional breakpoint',
        },
        c = { "<cmd>lua require'dap'.continue()<CR>", 'Continue' },
        C = { "<cmd>lua require'dap'.run_to_cursor()<CR>", 'Run To Cursor' },
        d = { "<cmd>lua require'dap'.disconnect()<CR>", 'Disconnect' },
        g = { "<cmd>lua require'dap'.session()<CR>", 'Get Session' },
        i = { "<cmd>lua require'dap'.step_into()<CR>", 'Step Into' },
        o = { "<cmd>lua require'dap'.step_over()<CR>", 'Step Over' },
        u = { "<cmd>lua require'dap'.step_out()<CR>", 'Step Out' },
        p = { "<cmd>lua require'dap'.pause()<CR>", 'Pause' },
        r = { "<cmd>lua require'dap'.repl.toggle()<CR>", 'Toggle Repl' },
        s = { "<cmd>lua require'dap'.continue()<CR>", 'Start' },
        q = { "<cmd>lua require'dap'.close()<CR>", 'Quit' },
        U = { "<cmd>lua require'dapui'.toggle({reset = true})<CR>", 'Toggle UI' },
      },

      t = {
        name = 'Test',
        t = { "<cmd>lua require('neotest').run.run()<CR>", 'Run' },
        T = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", 'Run DAP' },
        f = { [[<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>]], 'Run File' },
        s = { "<cmd>lua require('neotest').summary.toggle()<CR>", 'Summary' },
        o = { "<cmd>lua require('neotest').output.open({enter = true})<CR>", 'Output' },
        O = { "<cmd>lua require('neotest').output_panel.toggle()<CR>", 'Output Panel' },
      },
    }, { prefix = prefix })
  end,
}
