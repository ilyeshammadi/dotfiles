local files_opts = { layout = 'ivy_split', formatters = {
  file = { truncate = 120 },
}, hidden = true }

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    indent = { enabled = true, indent = { char = '┊' }, animate = { enabled = false }, scope = { enabled = false, char = '┊' } },
    scope = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true, layout = 'ivy' },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = {
      enabled = true,
    },
    zen = { enabled = true, toggles = { dim = false } },
    styles = {
      zen = {
        relative = 'editor',
        backdrop = { transparent = false },
      },
    },
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
          auto_close = false,
        }
      end,
      desc = 'Explorer',
    },
    {
      '<leader>f',
      function()
        Snacks.picker.files(files_opts)
      end,
      desc = 'Find Files',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Lines',
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
        Snacks.picker.grep_word { hidden = true }
      end,
      desc = 'Grep Under Cursor',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep { hidden = true }
      end,
      desc = 'Grep',
    },
    {
      '<leader>se',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Edited Files',
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
        Snacks.picker.recent(files_opts)
      end,
      desc = 'Recent Files',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'LSP Symbols',
    },
    -- -- LSP
    -- {
    --   'gd',
    --   function()
    --     Snacks.picker.lsp_definitions()
    --   end,
    --   desc = 'Goto Definition',
    -- },
    -- {
    --   'gD',
    --   function()
    --     Snacks.picker.lsp_declarations()
    --   end,
    --   desc = 'Goto Declaration',
    -- },
    -- {
    --   'gr',
    --   function()
    --     Snacks.picker.lsp_references()
    --   end,
    --   nowait = true,
    --   desc = 'References',
    -- },
    -- {
    --   'gI',
    --   function()
    --     Snacks.picker.lsp_implementations()
    --   end,
    --   desc = 'Goto Implementation',
    -- },
    -- {
    --   'gy',
    --   function()
    --     Snacks.picker.lsp_type_definitions()
    --   end,
    --   desc = 'Goto T[y]pe Definition',
    -- },
    {
      '<leader>ss',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'LSP Symbols',
    },
    {
      '<leader>sS',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = 'LSP Workspace Symbols',
    },

    {
      '<leader><leader>',
      function()
        Snacks.scratch { name = 'notes', file = './notes.md', ft = 'md' }
      end,
      desc = 'Toggle Scratch Notes',
    },
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end

        -- Override print to use snacks for `:=` command
        if vim.fn.has("nvim-0.11") == 1 then
          vim._print = function(_, ...)
            dd(...)
          end
        else
          vim.print = _G.dd 
        end
      end,
    })
  end,
}
