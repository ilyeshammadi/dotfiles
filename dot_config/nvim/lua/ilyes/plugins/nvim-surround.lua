return {
  'kylechui/nvim-surround',
  version = '*',
  event = 'BufReadPre',
  enabled = true,
  config = function()
    require('nvim-surround').setup {}
  end,
}
