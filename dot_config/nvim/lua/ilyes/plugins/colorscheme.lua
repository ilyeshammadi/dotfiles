require('rose-pine').setup {
  styles = {
    bold = true,
    italic = false,
    transparency = false,
  },
}

vim.cmd.colorscheme 'rose-pine'

local palette = require 'rose-pine.palette'

-- golang struct tags
vim.api.nvim_set_hl(0, '@tag.gostruct', { fg = palette.rose })

-- rose-pine doesn't define these; nvim-dap-view links to them, so they would render unstyled.
vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = palette.love })
vim.api.nvim_set_hl(0, 'qfFileName', { fg = palette.foam })
vim.api.nvim_set_hl(0, 'qfLineNr', { fg = palette.gold })
-- Variable/watch names link to Identifier, which rose-pine leaves near-white.
vim.api.nvim_set_hl(0, 'NvimDapViewWatchExpr', { fg = palette.iris })

-- nvim-dap's signs/stopped line link to groups rose-pine leaves empty.
vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = palette.gold })
vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { fg = palette.muted })
vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = palette.foam })
vim.api.nvim_set_hl(0, 'DapStopped', { fg = palette.pine })
vim.api.nvim_set_hl(0, 'debugPC', { bg = palette.highlight_med })
