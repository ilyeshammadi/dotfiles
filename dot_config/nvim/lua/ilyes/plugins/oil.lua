return {
  'stevearc/oil.nvim',
  lazy = true,
  event = 'VeryLazy',
  opts = {
    default_file_explorer = false,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
