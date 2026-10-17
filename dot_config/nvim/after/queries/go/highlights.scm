; extends

; `gopls` semantic tokens (priority 125) would otherwise redraw this range as
; a plain string on top of our capture (treesitter default priority is 100).
(field_declaration
  tag: (raw_string_literal) @tag.gostruct
  (#set! "priority" 200))
