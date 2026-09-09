-- nvim-treesitter `main` branch: parsers are installed explicitly and
-- highlighting is started per filetype. `:TSUpdate` after a plugin update is
-- handled by the PackChanged hook in ilyes.pack.
local filetypes =
  { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'go', 'python', 'dockerfile', 'fish', 'yaml', 'helm' }

require('nvim-treesitter').install(filetypes)

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    vim.treesitter.start()
  end,
})

-- Start treesitter for the current buffer if it's already loaded
local ft = vim.bo.filetype
if vim.tbl_contains(filetypes, ft) then
  vim.treesitter.start()
end
