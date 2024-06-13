return {
  'NeogitOrg/neogit',
  lazy = true,
  cmd = { 'Neogit', 'NeogitResetState' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  config = true,
}
