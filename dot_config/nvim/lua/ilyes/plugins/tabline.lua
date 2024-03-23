return {
  'crispgm/nvim-tabline',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('tabline').setup {
      show_index = false, -- show tab index
      show_modify = false, -- show buffer modification indicator
      show_icon = false, -- show file extension icon
      fnamemodify = ':t', -- file name modifier
      modify_indicator = '[+]', -- modify indicator
      no_name = 'No name', -- no name buffer name
      brackets = { '[', ']' }, -- file name brackets surrounding
      inactive_tab_max_length = 0, -- max length of inactive tab titles, 0 to ignore
    }
		vim.cmd('hi TabLine guifg=#54546D')
  end,
}
