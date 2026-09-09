require('treesitter-context').setup {
  enable = true,
  max_lines = 2,
  multiline_threshold = 1,
  trim_scope = 'inner',
}
