local icons = require 'ilyes.core.icons'
return {
  'lewis6991/gitsigns.nvim',
  event = 'BufRead',
  opts = {
    signs = {
      add = { text = icons.ui.BoldLineLeft },
      change = { text = icons.ui.BoldLineLeft },
      delete = { text = icons.ui.Triangle },
      topdelete = { text = icons.ui.Triangle },
      changedelete = { text = icons.ui.BoldLineLeft },
    },
  },
}
