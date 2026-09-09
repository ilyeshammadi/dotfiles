-- Plugins via `vim.pack` (`:help vim.pack`). It only installs and `:packadd`s:
-- every `setup()` lives in `ilyes.plugins.*` and is required below, in order.
-- There is no dependency resolution, so that order IS the dependency graph.

-- Build hooks. Must be registered before the first `vim.pack.add()`, otherwise
-- they are skipped on a fresh install.
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('ilyes-pack-build', { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind

    if name == 'LuaSnip' and (kind == 'install' or kind == 'update') and vim.fn.executable 'make' == 1 then
      vim.system({ 'make', 'install_jsregexp' }, { cwd = ev.data.path })
    end

    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
  end,
})

vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',

  { src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },

  'https://github.com/folke/snacks.nvim',
  { src = 'https://github.com/echasnovski/mini.nvim', version = vim.version.range '*' },

  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context', version = 'master' },

  -- blink.cmp must precede nvim-lspconfig: it supplies the LSP capabilities.
  { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range '2.*' },
  'https://github.com/rafamadriz/friendly-snippets',
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.*' },

  'https://github.com/mason-org/mason.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/qvalentin/helm-ls.nvim',
  'https://github.com/neovim/nvim-lspconfig',

  'https://github.com/stevearc/conform.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/hedyhli/outline.nvim',
  'https://github.com/crispgm/nvim-tabline',
  'https://github.com/ThePrimeagen/harpoon',
  'https://github.com/christoomey/vim-tmux-navigator',

  'https://github.com/OXY2DEV/markview.nvim',
  'https://github.com/obsidian-nvim/obsidian.nvim',
}

-- Colorscheme first, so a slow plugin below can't leave the UI unstyled.
require 'ilyes.plugins.colorscheme'
require 'ilyes.plugins.snacks'
require 'ilyes.plugins.mini'
require 'ilyes.plugins.treesitter'
require 'ilyes.plugins.treesitter-context'
require 'ilyes.plugins.blink'
require 'ilyes.plugins.lspconfig'
require 'ilyes.plugins.conform'
require 'ilyes.plugins.oil'
require 'ilyes.plugins.outline'
require 'ilyes.plugins.nvim-tabline'
require 'ilyes.plugins.obsidian'
require 'ilyes.plugins.which-key'

-- Not needed to draw the first screen, so kept off the startup path.
vim.schedule(function()
  vim.pack.add {
    'https://github.com/junegunn/fzf',
    'https://github.com/kevinhwang91/nvim-bqf',

    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/antoinemadec/FixCursorHold.nvim',
    'https://github.com/nvim-neotest/neotest',
    'https://github.com/nvim-neotest/neotest-python',
    'https://github.com/nvim-neotest/neotest-go',

    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/jay-babu/mason-nvim-dap.nvim',
    'https://github.com/theHamsta/nvim-dap-virtual-text',
    'https://github.com/mfussenegger/nvim-dap-python',
    'https://github.com/leoluz/nvim-dap-go',

  }

  require 'ilyes.plugins.nvim-bqf'
  require 'ilyes.plugins.neotest'
  require 'ilyes.plugins.dap'
end)
