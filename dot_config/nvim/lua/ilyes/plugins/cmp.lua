local icons = require 'ilyes.core.icons'

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert {
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'buffer', keyword_length = 3 },
      },
      window = {
        completion = {
          border = 'rounded',
        },
        documentation = {
          border = 'rounded',
        },
      },
      formatting = {
        fields = { 'abbr', 'kind' },
        kind_icons = icons.kind,
        format = function(_, vim_item)
          vim_item.kind = icons.kind[vim_item.kind] .. ' ' .. vim_item.kind
          return vim_item
        end,
      },
    }
  end,
}
