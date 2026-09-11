-- First: mocks nvim-web-devicons for every plugin loaded after it.
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

require('mini.bracketed').setup {
  diagnostic = { options = { float = false, severity = vim.diagnostic.severity.ERROR } },
}
require('mini.ai').setup()
require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.diff').setup {
  view = {
    style = 'sign',
    signs = { add = '▎', change = '▎', delete = '󰐊' },
  },
}

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
