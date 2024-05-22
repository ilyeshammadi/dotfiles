vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('ilyes-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Disable diagnostic messages for some languages',
  group = vim.api.nvim_create_augroup('ilyes-disable-diagnostic', { clear = true }),
  pattern = { 'python' },
  callback = function()
    vim.diagnostic.config { virtual_text = false, signs = false }
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

-- Display cursorline only for active window
vim.cmd [[
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END
au FileType TelescopePrompt* setlocal nocursorline
]]

vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  callback = function()
    vim.cmd 'highlight lualine_c_normal guibg=none'
    vim.cmd 'highlight lualine_c_inactive guibg=none'
  end,
})

-- Create an autocommand group and the autocommand
vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('ilyes-format-onsave', { clear = true }),
  pattern = '*', -- Apply to all files
  callback = function()
    local filetypes_to_skip = { 'python' }
    for _, ft in ipairs   (filetypes_to_skip) do
      if vim.bo.filetype ~= ft then
				require('conform').format()
      end
    end
  end,
})
