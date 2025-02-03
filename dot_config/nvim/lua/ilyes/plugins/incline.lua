return {
  'b0o/incline.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = 'BufReadPre',
  config = function()
    require('incline').setup {
      -- highlight = {
      --   groups = {
      --     InclineNormal = { guibg = 'none', guifg = '#C8C093' },
      --     InclineNormalNC = { guibg = 'none', guifg = '#54546d' },
      --   },
      -- },
      window = {
        padding = 0,
        margin = { horizontal = 0, vertical = 0 },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        if filename == '' then
          filename = '[No Name]'
        end

        local res = {
          ' ',
          filename,
          guibg = 'none',
        }
        table.insert(res, ' ')
        return res
      end,
    }
  end,
}
