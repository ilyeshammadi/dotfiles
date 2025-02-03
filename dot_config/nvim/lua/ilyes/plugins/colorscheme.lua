return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        highlight_groups = {
          -- Comment = { fg = "foam" },
          -- VertSplit = { fg = "muted", bg = "muted" },
          InclineNormal = { bg = '', fg = 'foam' },
          InclineNormalNC = { bg = '', fg = 'muted' },
          StatusLine = { bg = '', fg = 'muted' },
        },
      }
      vim.cmd 'colorscheme rose-pine'
    end,
  },
}
