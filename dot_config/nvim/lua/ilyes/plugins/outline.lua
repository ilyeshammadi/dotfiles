local icons = require 'ilyes.core.icons'
return {
  'simrat39/symbols-outline.nvim',
  cmd = 'SymbolsOutline',
  config = function()
    require('symbols-outline').setup {
      symbols = {
        File = { icon = icons.kind.File },
        Module = { icon = icons.kind.Module },
        Namespace = { icon = icons.kind.Namespace },
        Package = { icon = icons.kind.Package },
        Class = { icon = icons.kind.Class },
        Method = { icon = icons.kind.Method },
        Property = { icon = icons.kind.Property },
        Field = { icon = icons.kind.Field },
        Constructor = { icon = icons.kind.Constructor },
        Enum = { icon = icons.kind.Enum },
        Interface = { icon = icons.kind.Interface },
        Function = { icon = icons.kind.Function },
        Variable = { icon = icons.kind.Variable, hl = 'CmpItemKindVariable' },
        Constant = { icon = icons.kind.Constant },
        String = { icon = icons.kind.String },
        Number = { icon = icons.kind.Number },
        Boolean = { icon = icons.kind.Boolean },
        Array = { icon = icons.kind.Array },
        Object = { icon = icons.kind.Object },
        Key = { icon = icons.kind.Key },
        Null = { icon = icons.kind.Null },
        EnumMember = { icon = icons.kind.EnumMember },
        Struct = { icon = icons.kind.Struct },
        Event = { icon = icons.kind.Event },
        Operator = { icon = icons.kind.Operator },
        TypeParameter = { icon = icons.kind.TypeParameter },
        Component = { icon = icons.kind.Function },
        Fragment = { icon = icons.kind.Constant },
      },
    }
  end,
}
