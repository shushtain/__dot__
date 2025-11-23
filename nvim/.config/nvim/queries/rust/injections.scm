;extends

; --- rusqlite: .execute(r"", _)
; (call_expression
;   function: (field_expression
;     value: (_)
;     field: (field_identifier) @_field_id
;     (#any-of? @_field_id "execute" "prepare"))
;   arguments: (arguments
;     (raw_string_literal
;       (string_content) @injection.content
;       (#set! injection.language "sql"))
;     (_)?))
