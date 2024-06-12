return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  enabled = true,
  lazy = false,
  config = function()
    -- Override theme to force transparent
    local theme = require 'lualine.themes.kanagawa'
    theme.normal.c.fg = '#C8C093'
    theme.normal.c.bg = 'NONE'
    theme.inactive.c.fg = '#54546d'
    theme.inactive.c.bg = 'NONE'

    local icons = require 'ilyes.core.icons'

    local sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          'filename',
          file_status = true,
          padding = { left = 1, right = 1 },
          path = 1,
          icon_only = true,
          shorting_target = 10,
        },
        {
          function()
            if require('arrow.statusline').is_on_arrow_file() ~= nil then
              return icons.ui.BookMark
            else
              return ' '
            end
          end,
          padding = { left = 0, right = 0 },
        },
      },
      lualine_x = {
        {
          'progress',
          fmt = function()
            return '%P/%L'
          end,
        },
      },
      lualine_y = {},
      lualine_z = {},
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = theme,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          'neo-tree',
          'Outline',
        },
        globalstatus = false,
        refresh = {
          statusline = 100,
        },
      },
      sections = sections,
      inactive_sections = sections,
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
