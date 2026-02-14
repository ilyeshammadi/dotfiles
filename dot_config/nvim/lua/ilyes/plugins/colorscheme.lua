return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        styles = {
          bold = true,
          italic = false,
          transparency = false,
        },
        -- highlight_groups = {
        --   Comment = { italic = true },
        --   InclineNormal = { bg = '', fg = 'foam' },
        --   InclineNormalNC = { bg = '', fg = 'muted' },
        --   StatusLine = { bg = '', fg = 'muted' },
        --   TreesitterContext = { bg = 'base' },
        --   TreesitterContextLineNumber = { bg = 'base', fg = 'muted' },
        --   MsgArea = { bg = 'base' },
        --   MsgSeparator = { bg = 'base' },
        --   FloatBorder = { bg = 'base' },
        --   NormalFloat = { bg = 'base' },
        --   Pmenu = { fg = 'muted', bg = 'base' },
        --   WhichKeyFloat = { bg = 'base' },
        --   WhichKeyBorder = { bg = 'base' },
        -- },
      }
      vim.cmd 'colorscheme rose-pine'
    end,
  },
  { 'catppuccin/nvim', name = 'catppuccin' },
}
