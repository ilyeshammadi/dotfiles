return {
  'b0o/incline.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = 'BufReadPre',
  config = function()
    local devicons = require 'nvim-web-devicons'
    require('incline').setup {
      window = {
        padding = 0,
        margin = { horizontal = 0, vertical = 0 },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        if filename == '' then
          filename = '[No Name]'
        end

        local ft_icon = devicons.get_icon(filename)

        local res = {
          ' ',
          ft_icon,
          '  ',
          filename,
          guibg = 'none',
        }
        table.insert(res, ' ')
        return res
      end,
    }
  end,
}
