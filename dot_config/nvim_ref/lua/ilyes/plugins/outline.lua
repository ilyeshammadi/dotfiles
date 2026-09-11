-- Icons come from mini.icons (set up in ilyes.plugins.mini), which supplies a
-- glyph and a highlight group per LSP symbol kind. Kinds outline.nvim invents
-- (Component, Fragment, ...) keep its own defaults.
local symbols = {}
for _, kind in ipairs(vim.lsp.protocol.SymbolKind) do
  local icon, hl = MiniIcons.get('lsp', kind)
  symbols[kind] = { icon = icon, hl = hl }
end

require('outline').setup { symbols = { icons = symbols } }

vim.keymap.set('n', '<leader>lo', '<cmd>Outline<CR>', { desc = 'Toggle outline' })
