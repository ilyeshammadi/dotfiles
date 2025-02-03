return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    indent = { enabled = true, char = '┊', animate = { enabled = false }, scope = { char = '┊' } },
    scope = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true, layout = { preset = 'telescope' } },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    zen = { enabled = true, toggles = { dim = false } },
  },
  keys = {
    {
      '<leader>z',
      function()
        Snacks.zen()
      end,
      desc = 'Zen',
    },
    {
      '<leader>e',
      function()
        Snacks.explorer.open {
          auto_close = true,
        }
      end,
      desc = 'Explorer',
    },
    {
      '<leader>f',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find files',
    },
    {
      '<leader>gb',
      function()
        Snacks.git.blame_line()
      end,
      desc = 'Git Blame Line',
    },
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
      mode = { 'n', 'v' },
    },

    {
      '<leader>sG',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Grep under cursor',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>sl',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent Files',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.inlay_hints():map '<leader>uh'
        Snacks.toggle.dim():map '<leader>uD'
      end,
    })
  end,
}
