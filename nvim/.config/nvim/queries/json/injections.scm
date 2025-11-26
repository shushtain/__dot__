;extends

(object
  (pair
    key: (_) @kind
    value: (_) @text)
  (pair
    key: (_) @text
    value: (_) @injection.content)
  (#match? @kind "kind")
  (#match? @text "text")
  (#set! injection.language "markdown"))
