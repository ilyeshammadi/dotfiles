local map = vim.keymap.set

-- Move on display lines like real lines
map('n', 'j', 'gj')
map('n', 'gj', 'j')
map('n', 'k', 'gk')
map('n', 'gk', 'k')

-- Use <Esc> to turn off search highlighting
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keep indenting when moving lines
map('v', '>', '>gv')
map('v', '<', '<gv')

-- Move lines up and down
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Zzzzz
map('n', 'x', '"_x')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', 'G', 'Gzz')

-- Next tab
map('n', ']t', '<cmd>tabnext<CR>', { silent = true, desc = 'Next tab' })
map('n', '[t', '<cmd>tabprevious<CR>', { silent = true, desc = 'Previous tab' })

map('n', '-', '<cmd>Oil --float<CR>', { desc = '🫒 Oil' })

-- `]q`/`[q` are Nvim defaults.
map('n', ']Q', '<cmd>cnewer<CR>', { desc = 'Next quickfix list', silent = true })
map('n', '[Q', '<cmd>colder<CR>', { desc = 'Previous quickfix list', silent = true })
map('n', 'qq', function()
  vim.cmd(vim.fn.getqflist({ winid = 0 }).winid == 0 and 'copen' or 'cclose')
end, { desc = 'Toggle quickfix', silent = true })

-- `K` and the `gr*`/`gO` set are Nvim defaults.
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto definition' })
map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto declaration' })
map('n', 'gs', vim.lsp.buf.signature_help, { desc = 'Show signature help' })
map('n', 'gl', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })

map('n', '[c', function() require('treesitter-context').go_to_context(vim.v.count1) end, { silent = true, desc = 'Previous context' })

-- Harpoon
map('n', ',', function() require('harpoon.ui').toggle_quick_menu() end)
map('n', '<C-s>', function() require('harpoon.mark').add_file() end)
map('n', '<Left>', function()
  require('harpoon.ui').nav_next()
  vim.cmd 'norm zz'
end)
map('n', '<Right>', function()
  require('harpoon.ui').nav_prev()
  vim.cmd 'norm zz'
end)
