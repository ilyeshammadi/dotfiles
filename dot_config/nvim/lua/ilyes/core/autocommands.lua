vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('ilyes-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Restore cursor position in file (see `:help restore-cursor`)',
  group = vim.api.nvim_create_augroup('ilyes-restore-cursor', { clear = true }),
  callback = function(ev)
    local ft = vim.bo[ev.buf].filetype
    local line = vim.api.nvim_buf_get_mark(ev.buf, '"')[1]
    if not ft:match 'commit' and not ft:match 'rebase' and line > 1 and line <= vim.api.nvim_buf_line_count(ev.buf) then
      vim.cmd 'normal! g`"'
    end
  end,
})
