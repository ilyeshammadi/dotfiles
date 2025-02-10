return {
  'rose-pine/neovim',
  name = 'rose-pine',
  config = function()
    require('rose-pine').setup {
      styles = {
        bold = true,
        italic = false,
        transparency = false,
      },
      highlight_groups = {
        InclineNormal = { bg = '', fg = 'foam' },
        InclineNormalNC = { bg = '', fg = 'muted' },
        StatusLine = { bg = '', fg = 'muted' },
        TreesitterContext = { bg = 'base' },
        TreesitterContextLineNumber = { bg = 'base' },
        MsgArea = { bg = 'base' },
        MsgSeparator = { bg = 'base' },
      },
    }
    vim.cmd 'colorscheme rose-pine'
  end,
}
