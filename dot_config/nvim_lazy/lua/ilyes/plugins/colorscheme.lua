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
      }
      vim.cmd 'colorscheme rose-pine'
    end,
  },
  { 'catppuccin/nvim', name = 'catppuccin' },
}
