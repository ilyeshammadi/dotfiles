vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('ilyes-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufRead', {
  desc = 'Preseve cursor position in file',
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if not (ft:match 'commit' and ft:match 'rebase') and last_known_line > 1 and last_known_line <= vim.api.nvim_buf_line_count(opts.buf) then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})

-- Create an autocommand group and the autocommand
vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('ilyes-format-onsave', { clear = true }),
  pattern = '*', -- Apply to all files
  callback = function()
    local filetypes_to_skip = { 'python' }
    for _, ft in ipairs(filetypes_to_skip) do
      if vim.bo.filetype ~= ft then
        require('conform').format()
      end
    end
  end,
})
