return {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufRead',
  config = function()
    require('treesitter-context').setup {
      max_lines = 2,
      multiline_threshold = 1,
      trim_scope = 'inner',
    }
  end,
}
