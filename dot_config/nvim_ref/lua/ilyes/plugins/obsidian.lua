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
