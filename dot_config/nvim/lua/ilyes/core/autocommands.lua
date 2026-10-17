vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('ilyes-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- `vim.lsp.status()` drains a ring buffer, so it shows each message once then
-- goes blank. Track progress per token ourselves so it persists until done.
local lsp_progress = {}

_G.lsp_status = function()
  local parts = {}
  for _, p in pairs(lsp_progress) do
    local percentage = p.percentage and (p.percentage .. '%: ') or ''
    parts[#parts + 1] = percentage .. (p.title or '') .. (p.message and (' ' .. p.message) or '')
  end
  return table.concat(parts, ', ')
end

vim.api.nvim_create_autocmd('LspProgress', {
  desc = 'Track LSP progress for the statusline (see `_G.lsp_status`)',
  group = vim.api.nvim_create_augroup('ilyes-lsp-progress', { clear = true }),
  callback = function(ev)
    local value = ev.data.params.value
    local key = ev.data.client_id .. ':' .. tostring(ev.data.params.token)

    if value.kind == 'end' then
      lsp_progress[key] = nil
    else
      -- `report`/`end` messages don't repeat `title`, so merge over the prior entry.
      lsp_progress[key] = vim.tbl_extend('force', lsp_progress[key] or {}, value)
    end

    vim.cmd.redrawstatus()
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
