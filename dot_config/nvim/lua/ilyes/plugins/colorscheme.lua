require('rose-pine').setup {
  styles = {
    bold = true,
    italic = false,
    transparency = false,
  },
}

vim.cmd.colorscheme 'rose-pine'

local palette = require 'rose-pine.palette'
vim.api.nvim_set_hl(0, '@tag.gostruct', { fg = palette.rose })
