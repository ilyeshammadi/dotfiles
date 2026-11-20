; Replaces nvim-treesitter's http injections (no `;; extends`) so HTML bodies
; are not also injected as XML. Keep in sync with the upstream file.

; Comments
((comment) @injection.content
  (#set! injection.language "comment"))

; <!DOCTYPE html> or <html ...> (any case) is HTML, other markup is XML.
; Body: response bodies starting with `<` parse as xml_body, `{`/`[` as raw_body.
; trim! drops trailing blank lines: a body at EOF otherwise ends past the last
; line and conform's `injected` formatter fails with "Index out of bounds".
((json_body) @injection.content
  (#trim! @injection.content)
  (#set! injection.language "json"))

((raw_body) @injection.content
  (#lua-match? @injection.content "^%s*[{[]")
  (#trim! @injection.content)
  (#set! injection.language "json"))

((xml_body) @injection.content
  (#lua-match? @injection.content "^%s*<[!%w%s]-[Hh][Tt][Mm][Ll][%s>]")
  (#set! injection.language "html"))

((xml_body) @injection.content
  (#not-lua-match? @injection.content "^%s*<[!%w%s]-[Hh][Tt][Mm][Ll][%s>]")
  (#set! injection.language "xml"))

((graphql_data) @injection.content
  (#set! injection.language "graphql"))

; Script (default to javascript)
((comment
  name: (_) @_name
  (#eq? @_name "lang")
  value: (_) @injection.language)?
  .
  (_
    (script) @injection.content
    (#offset! @injection.content 0 2 0 -2))
  (#set! injection.language "javascript"))
