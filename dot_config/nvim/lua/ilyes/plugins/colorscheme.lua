return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('kanagawa').setup {
      transparent = true,
      overrides = function(colors)
        local theme = colors.theme
        local palette = colors.palette

        local hl = {
          Pmenu = { fg = theme.ui.float.fg_border, bg = theme.ui.bg },
          PmenuSel = { fg = '', bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          FloatBorder = { bg = theme.ui.bg },
          NormalFloat = { bg = theme.ui.bg },
          TreesitterContext = { bg = theme.ui.bg },
          TreesitterContextLineNumber = { fg = palette.sumiInk6 },
          CursorLineNr = { fg = palette.sumiInk6 },
          FlashLabel = { bg = palette.autumnRed },
          MsgArea = { fg = palette.sumiInk6 },
          MsgSeparator = { bg = theme.ui.bg },
          ModeMsg = { fg = palette.sumiInk6 },
          IncSearch = { bg = palette.roninYellow },
          MiniIndentscopeSymbol = { fg = palette.oldWhite },
          MiniIndentscopeSymbolOff = { fg = palette.oldWhite, bg = palette.oldWhite },
        }

        -- Transparent
        hl.Pmenu = { bg = '' }
        hl.PmenuSbar = { bg = '' }
        hl.TreesitterContext = { bg = '' }
        hl.NormalFloat = { bg = '' }
        hl.FloatBorder = { bg = '' }
        hl.FloatTitle = { bg = '' }
        hl.MsgSeparator = { bg = '' }
        hl.TabLine = { bg = '' }
        hl.TabLineFill = { bg = '' }
        hl.TabLineSel = { bg = '' }
        hl.FloatShadow = { bg = '' }
        hl.FloatShadowThrough = { bg = '' }
        hl.TelescopeBorder = { bg = '' }
        hl.StatusLine = { bg = '', fg = palette.sumiInk6 }
        hl.StatusLineNC = { bg = '', fg = palette.sumiInk6 }
        hl.FloatermBorder = { bg = '' }
        hl.FloatFooter = { bg = '' }
        hl.Folded = { bg = '' }

        return hl
      end,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
    }
    vim.cmd 'colorscheme kanagawa'
  end,
}
