-- markview.nvim configures itself via its own `plugin/` file; it only needs to
-- be present on the runtimepath, which ilyes.pack takes care of.
require('obsidian').setup {
  legacy_commands = false,
  templates = {
    folder = 'templates',
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
    name = 'snacks.picker',
  },
}
