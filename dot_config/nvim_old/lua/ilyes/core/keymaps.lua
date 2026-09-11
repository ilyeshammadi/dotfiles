-- Helper functions
local nnoremap = function(from, to, opts)
  vim.keymap.set('n', from, to, opts)
end

local vnoremap = function(from, to, opts)
  vim.keymap.set('v', from, to, opts)
end

-- Move on display lines like real lines
nnoremap('j', 'gj')
nnoremap('gj', 'j')
nnoremap('k', 'gk')
nnoremap('gk', 'k')

-- Use <Esc> to turn off search highlighting
nnoremap('<Esc>', '<cmd>nohlsearch<CR>')

-- Keep indenting when moving lines
vnoremap('>', '>gv')
vnoremap('<', '<gv')

-- Move lines up and down
vnoremap('J', ":m '>+1<CR>gv=gv")
vnoremap('K', ":m '<-2<CR>gv=gv")

-- Zzzzz
nnoremap('x', '"_x')
nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')
nnoremap('n', 'nzz')
nnoremap('N', 'Nzz')
nnoremap('G', 'Gzz')
nnoremap('gd', 'gdzz')
nnoremap('gr', 'grzz')

-- Next tab
nnoremap(']t', '<cmd>tabnext<CR>', { silent = true, desc = 'Next tab' })
nnoremap('[t', '<cmd>tabprevious<CR>', { silent = true, desc = 'Previous tab' })

-- Add white space before or after
nnoremap('[<space>', 'O<esc>j')
nnoremap(']<space>', 'o<esc>k')

nnoremap('-', '<cmd>Oil --float<CR>', { desc = '🫒 Oil' })

-- Quick fix
nnoremap(']q', '<cmd>silent cnext<CR>', { desc = 'Next quickfix list item', silent = true })
nnoremap('[q', '<cmd>silent cprevious<CR>', { desc = 'Previous quickfix list item', silent = true })
nnoremap(']Q', '<cmd>cnewer<CR>', { desc = 'Next quickfix list', silent = true })
nnoremap('[Q', '<cmd>colder<CR>', { desc = 'Previous quickfix list', silent = true })
-- Toggle quick fix list
vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]
nnoremap('qq', [[:call QuickFixToggle()<CR>]], { desc = 'Toggle quickfix', silent = true })

-- LSP
nnoremap('K', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'Show hover' })
nnoremap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = 'Goto definition' })
nnoremap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = 'Goto declaration' })
nnoremap('gr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = 'Goto refernces' })
nnoremap('gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = 'Goto implementation' })
nnoremap('gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = 'Show signature help' })
nnoremap('gl', function()
  vim.diagnostic.config { virtual_lines = { current_line = true } }
vim.api.nvim_create_autocmd('CursorMoved', {
  group = vim.api.nvim_create_augroup('line-diagnostics', { clear = true }),
  callback = function()
    vim.diagnostic.config { virtual_lines = false }
    return true
  end,
})
end, { desc = 'Show line diagnostics' })

-- Treesitter context
nnoremap('[c', function()
  require('treesitter-context').go_to_context(vim.v.count1)
end, { silent = true, desc = 'Previous context' })

-- Neotest
nnoremap('tt', ":lua require('neotest').run.run()<CR>", { desc = 'Run current test', silent = true })

-- Harpoon
nnoremap(',', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>')
nnoremap('<C-s>', '<cmd>lua require("harpoon.mark").add_file()<CR>')
nnoremap('<Left>', function()
  require('harpoon.ui').nav_next()
  vim.cmd 'norm zz'
end)
nnoremap('<Right>', function()
  require('harpoon.ui').nav_prev()
  vim.cmd 'norm zz'
end)
