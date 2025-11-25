;extends

(pair
  key: (_) @key
  (#match? @key "text")
  value: (_) @injection.content
  (#set! injection.language "markdown"))
