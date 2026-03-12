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
    templates = {
      folder = 'templates',
    },
    note = {
      template = 'default.md',
    },
    daily_notes = {
      folder = 'dailies',
    },
    workspaces = {
      {
        name = 'personal',
        path = '~/vaults/personal',
      },
      {
        name = 'work',
        path = '~/vaults/work',
      },
    },
    picker = {
      name = 'snacks.pick',
    },
  },
}
