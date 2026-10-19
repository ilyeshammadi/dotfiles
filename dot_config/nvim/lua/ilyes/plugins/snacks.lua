local icons = require 'ilyes.core.icons'

local files_opts = {
  layout = 'ivy_split',
  formatters = {
    file = { truncate = 120 },
  },
  hidden = true,
}

require('snacks').setup {
  bigfile = { enabled = true },
  indent = { enabled = true, indent = { char = '┊' }, animate = { enabled = false }, scope = { enabled = false, char = '┊' } },
  scope = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true, layout = 'ivy' },
  notifier = { enabled = false },
  quickfile = { enabled = true },
  statuscolumn = {
    enabled = true,
  },
  zen = { enabled = true, toggles = { dim = false } },
  styles = {
    zen = {
      relative = 'editor',
      backdrop = { transparent = false },
    },
  },
}

_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function()
  Snacks.debug.backtrace()
end

-- Route `:=` through snacks
vim._print = function(_, ...)
  dd(...)
end

local map = vim.keymap.set

map('n', '<leader>z', function()
  Snacks.zen()
end, { desc = 'Zen' })
map('n', '<leader>e', function()
  Snacks.explorer.open { auto_close = false }
end, { desc = 'Explorer' })
map('n', '<leader>f', function()
  Snacks.picker.files(files_opts)
end, { desc = 'Find Files' })
map('n', '<leader>/', function()
  Snacks.picker.lines()
end, { desc = 'Lines' })
map('n', '<leader>gb', function()
  Snacks.git.blame_line()
end, { desc = 'Git Blame Line' })
map({ 'n', 'v' }, '<leader>gB', function()
  Snacks.gitbrowse()
end, { desc = 'Git Browse' })
map('n', '<leader>sG', function()
  Snacks.picker.grep_word { hidden = true }
end, { desc = 'Grep Under Cursor' })
map('n', '<leader>sg', function()
  Snacks.picker.grep { hidden = true }
end, { desc = 'Grep' })
map('n', '<leader>se', function()
  Snacks.picker.git_status()
end, { desc = 'Edited Files' })
map('n', '<leader>sl', function()
  Snacks.picker.resume()
end, { desc = 'Resume' })
map('n', '<leader>sr', function()
  Snacks.picker.recent(files_opts)
end, { desc = 'Recent Files' })
map('n', '<leader>ss', function()
  Snacks.picker.lsp_symbols()
end, { desc = 'LSP Symbols' })
map('n', '<leader>sS', function()
  Snacks.picker.lsp_workspace_symbols()
end, { desc = 'LSP Workspace Symbols' })
map('n', '<leader><leader>', function()
  Snacks.scratch { name = 'notes', file = './notes.md', ft = 'md' }
end, { desc = 'Toggle Scratch Notes' })
map('n', '<leader>.', function()
  Snacks.scratch()
end, { desc = 'Toggle Scratch Buffer' })
map('n', '<leader>S', function()
  Snacks.scratch.select()
end, { desc = 'Select Scratch Buffer' })

require('which-key').add {
  { '<leader>z', icon = icons.snacks.zen },
  { '<leader>e', icon = icons.snacks.explorer },
  { '<leader>f', icon = icons.snacks.files },
  { '<leader>/', icon = icons.snacks.lines },
  { '<leader>gb', icon = icons.snacks.git_blame },
  { '<leader>gB', icon = icons.snacks.git_browse, mode = { 'n', 'v' } },
  { '<leader>sG', icon = icons.snacks.grep_word },
  { '<leader>sg', icon = icons.snacks.grep },
  { '<leader>se', icon = icons.snacks.git_status },
  { '<leader>sl', icon = icons.snacks.resume },
  { '<leader>sr', icon = icons.snacks.recent },
  { '<leader>ss', icon = icons.snacks.symbols },
  { '<leader>sS', icon = icons.snacks.workspace_symbols },
  { '<leader><leader>', icon = icons.snacks.scratch_notes },
  { '<leader>.', icon = icons.snacks.scratch },
  { '<leader>S', icon = icons.snacks.scratch_select },
}
