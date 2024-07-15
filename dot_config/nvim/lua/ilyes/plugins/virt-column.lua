return {
  'lukas-reineke/virt-column.nvim',
  event = 'BufReadPre',
  enabled = false,
  opts = {
    char = { '┆' },
    virtcolumn = '80',
    highlight = { 'NonText' },
  },
}
