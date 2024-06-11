local icons_ = require 'ilyes.core.icons'
return {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
  keys = {
    { '<leader>lo', '<cmd>Outline<CR>', desc = 'Toggle outline' },
  },
  opts = {
    symbols = {
      icons = {
        File = { icon = icons_.kind.File, hl = 'Identifier' },
        Module = { icon = icons_.kind.Module, hl = 'Include' },
        Namespace = { icon = icons_.kind.Namespace, hl = 'Include' },
        Package = { icon = icons_.kind.Package, hl = 'Include' },
        Class = { icon = icons_.kind.Class, hl = 'Type' },
        Method = { icon = icons_.kind.Method, hl = 'Function' },
        Property = { icon = icons_.kind.Property, hl = 'Identifier' },
        Field = { icon = icons_.kind.Field, hl = 'Identifier' },
        Constructor = { icon = icons_.kind.Constructor, hl = 'Special' },
        Enum = { icon = icons_.kind.Enum, hl = 'Type' },
        Interface = { icon = icons_.kind.Interface, hl = 'Type' },
        Function = { icon = icons_.kind.Function, hl = 'Function' },
        Variable = { icon = icons_.kind.Variable, hl = 'Constant' },
        Constant = { icon = icons_.kind.Constant, hl = 'Constant' },
        String = { icon = icons_.kind.String, hl = 'String' },
        Number = { icon = icons_.kind.Number, hl = 'Number' },
        Boolean = { icon = icons_.kind.Boolean, hl = 'Boolean' },
        Array = { icon = icons_.kind.Array, hl = 'Constant' },
        Object = { icon = icons_.kind.Object, hl = 'Type' },
        Key = { icon = icons_.kind.Key, hl = 'Type' },
        Null = { icon = icons_.kind.Null, hl = 'Type' },
        EnumMember = { icon = icons_.kind.EnumMember, hl = 'Identifier' },
        Struct = { icon = icons_.kind.Struct, hl = 'Structure' },
        Event = { icon = icons_.kind.Event, hl = 'Type' },
        Operator = { icon = icons_.kind.Operator, hl = 'Identifier' },
        TypeParameter = { icon = icons_.kind.TypeParameter, hl = 'Identifier' },
        Component = { icon = '󰅴', hl = 'Function' },
        Fragment = { icon = '󰅴', hl = 'Constant' },
        TypeAlias = { icon = ' ', hl = 'Type' },
        Parameter = { icon = ' ', hl = 'Identifier' },
        StaticMethod = { icon = ' ', hl = 'Function' },
        Macro = { icon = ' ', hl = 'Function' },
      },
    },
  },
}
