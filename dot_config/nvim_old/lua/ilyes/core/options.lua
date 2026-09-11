-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true

vim.opt.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!

vim.opt.showmode = true -- Don't show the mode, since it's already in status line

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true -- Enable break indent

vim.opt.undofile = true -- Save undo history

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default

vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300

vim.opt.splitright = true -- Configure how new splits should be opened
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!

vim.opt.cursorline = true -- Show which line your cursor is on

vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.

vim.opt.hlsearch = true -- Set highlight on search, but clear on pressing <Esc> in normal mode

-- Set default grep to ripgrep
vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case --hidden'
vim.o.grepformat = '%f:%l:%c:%m'
vim.opt.guicursor = 'i:block'

vim.opt.shortmess:append 'sIW' -- Disable welcome message
vim.o.wrap = true -- Wrap line
vim.o.foldmethod = 'expr' -- Use syntax based folding
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevelstart = 99 -- Open all folds by default

vim.o.fillchars = [[eob: ,fold: ,foldopen: ,foldsep: ,foldclose:]]
vim.o.foldcolumn = '0'
vim.o.foldenable = true

vim.o.swapfile = false -- Disable swap file

vim.o.errorformat = '%f|%l col %c|%m'
vim.o.laststatus = 3 -- Global status line
