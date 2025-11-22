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
; --- draft
; (((line_comment) @todo
;   (#match? @todo "TODO"))
;   (line_comment)* @comment)
; ((line_comment)+ @comment
;   (#any-match? @comment "TODO"))
