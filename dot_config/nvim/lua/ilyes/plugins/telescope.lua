local icons = require 'ilyes.core.icons'

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      version = '^1.0.0',
    },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
      defaults = {
        prompt_prefix = ' ' .. icons.ui.Telescope .. '  ',
        selection_caret = icons.ui.Forward .. ' ',
        file_ignore_patterns = {
          'node_modules',
          'vendor',
          'target',
          'dist',
          'build',
          'out',
        },
        layout_strategy = 'vertical',
        layout_config = { height = 0.95, width = 0.7 },
      },
      pickers = {
        find_files = {
          previewer = false,
        },
        oldfiles = {
          previewer = false,
        },
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'live_grep_args')
  end,
}
