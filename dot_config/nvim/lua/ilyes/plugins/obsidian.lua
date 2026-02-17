return {
  'obsidian-nvim/obsidian.nvim',
  -- version = '*', -- use latest release, remove to use latest commit
  dependencies = {
    {
      'OXY2DEV/markview.nvim',
      lazy = false,
    },
  },
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      {
        name = 'personal',
        path = '~/vaults/personal',
      },
    },
    templates = {
      folder = 'templates',
    },
  },
}
