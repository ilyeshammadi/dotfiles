return {
  'kylechui/nvim-surround',
  version = '*',
  event = 'VeryLazy',
  enabled = false,
  config = function()
    require('nvim-surround').setup {}
  end,
}
