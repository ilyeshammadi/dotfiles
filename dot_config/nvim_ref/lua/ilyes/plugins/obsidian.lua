-- Rendering is obsidian.nvim's own `ui` module (on by default); it warns if a
-- second markdown renderer is installed, so there isn't one.
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
