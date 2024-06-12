return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  lazy = true,
  event = 'VeryLazy',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc', 'json', 'yaml', 'python', 'javascript', 'rust' },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      ignore_install = {},
      modules = {},
      sync_install = false,
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = 'v',
          node_decremental = 'V',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,

          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ao'] = '@class.outer',
            ['io'] = '@class.inner',
            -- ['ai'] = '@block.outer',
            -- ['ii'] = '@block.inner',
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['ac'] = '@comment.outer',
            ['ic'] = '@comment.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = { query = '@function.outer', desc = 'Next function start' },
            [']]'] = { query = '@class.outer', desc = 'Next class start' },
          },
          goto_next_end = {
            [']M'] = { query = '@function.outer', desc = 'Next function end' },
            [']['] = { query = '@class.outer', desc = 'Next class end' },
          },
          goto_previous_start = {
            ['[m'] = { query = '@function.outer', desc = 'Previous function start' },
            ['[['] = { query = '@class.outer', desc = 'Previous class start' },
          },
          goto_previous_end = {
            ['[M'] = { query = '@function.outer', desc = 'Previous function end' },
            ['[]'] = { query = '@class.outer', desc = 'Previous class end' },
          },
        },
      },
    }
  end,
}
