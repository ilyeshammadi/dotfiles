local icons = require 'ilyes.core.icons'
local colors = require 'ilyes.core.colors'

local background_color = colors.transparent and 'NONE' or '#1F1F28'
local color = { fg = colors.sumiInk4, bg = background_color }

local bookmark = {
  function()
    if require('arrow.statusline').is_on_arrow_file() ~= nil then
      return icons.ui.BookMark
    else
      return ' '
    end
  end,
  padding = { left = 0, right = 0 },
  color = color,
}

local filename = {
  'filename',
  file_status = true,
  padding = { left = 1, right = 1 },
  path = 1,
  color = color,
  icon_only = true,
  shorting_target = 10,
}
local sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = {
    filename,
    bookmark,
  },
  lualine_x = {
    {
      'progress',
      fmt = function()
        return '%P/%L'
      end,
      color = { fg = colors.sumiInk4, bg = background_color },
    },
  },
  lualine_y = {},
  lualine_z = {},
}
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          'neo-tree',
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
      },
      sections = sections,
      inactive_sections = sections,
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
    vim.api.nvim_set_hl(0, 'lualine_c_normal', { background = background_color })
    vim.api.nvim_set_hl(0, 'lualine_c_inactive', { background = background_color })
  end,
}
