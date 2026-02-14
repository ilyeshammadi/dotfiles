return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    local filetypes =
      { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'go', 'python', 'dockerfile', 'fish' }
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
  end,
}
