return {
  'echasnovski/mini.nvim',
  event = 'VeryLazy',
  version = '*',
  config = function()
    require('mini.bracketed').setup()
    require('mini.ai').setup()
    require('mini.surround').setup()
    require('mini.pairs').setup()
    require('mini.comment').setup()
    require('mini.git').setup()
    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }

    local indentscope = require 'mini.indentscope'
    indentscope.setup {
      draw = {
        delay = 0,
        animation = indentscope.gen_animation.none(),
      },
      symbol = '┊',
    }
  end,
}
