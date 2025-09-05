; Forked from tree-sitter-go
; Copyright (c) 2014 Max Brunsfeld (The MIT License)
;
; Identifiers
(field_identifier) @property

(identifier) @variable

(package_identifier) @module

(parameter_declaration
  (identifier) @variable.parameter)

(variadic_parameter_declaration
  (identifier) @variable.parameter)

(label_name) @label

(const_spec
  name: (identifier) @constant)

; Operators
[
  "--"
  "-"
  "-="
  ":="
  "!"
  "!="
  "..."
  "*"
  "*"
  "*="
  "/"
  "/="
  "&"
  "&&"
  "&="
  "&^"
  "&^="
  "%"
  "%="
  "^"
  "^="
  "+"
  "++"
  "+="
  "<-"
  "<"
  "<<"
  "<<="
  "<="
  "="
  "=="
  ">"
  ">="
  ">>"
  ">>="
  "|"
  "|="
  "||"
  "~"
] @operator

; Keywords
[
  "const"
  "var"
] @keyword.declaration

[
  "default"
  "defer"
  "select"
] @keyword.branching

[
	"continue"
	"break"
  "goto"
  "fallthrough"
] @keyword.jumping

[
  "type"
  "struct"
  "interface"
] @keyword.type

(method_declaration) @keyword.function
(function_declaration) @keyword.function
(func_literal) @keyword.function.colorless

"return" @keyword.return

"go" @keyword.coroutine

[
	"range"
	"for"
] @keyword.repeat

[
  "import"
  "package"
] @keyword.import

[
  "else"
  "case"
  "switch"
  "if"
] @keyword.conditional

; types

(type_identifier) @type

(qualified_type) @type

(function_type) @type

(type_spec
  name: (type_identifier) @type)

((map_type) @type
	(#not-has-parent? @type field_declaration))

((map_type) @type.colorless
	(#has-parent? @type.colorless field_declaration))

((map_type) @type.colorless
	(#has-parent? @type.colorless type_spec))

((channel_type) @type
	(#not-has-parent? @type field_declaration))

((channel_type) @type.colorless
	(#has-parent? @type.colorless field_declaration))

((channel_type) @type.colorless
	(#has-parent? @type.colorless type_spec))

((type_identifier) @type
  (#any-of? @type
    "any" "bool" "byte" "comparable" "complex128" "complex64" "error" "float32" "float64" "int"
    "int16" "int32" "int64" "int8" "rune" "string" "uint" "uint16" "uint32" "uint64" "uint8"
    "uintptr"))

; functions

((call_expression
  (identifier) @function.constructor)
  (#lua-match? @function.constructor "^[nN]ew.+$"))

((call_expression
  (identifier) @function.constructor)
  (#lua-match? @function.constructor "^[mM]ake.+$"))

(call_expression
  function: (identifier) @function.call)

(call_expression
  function: (selector_expression
    field: (field_identifier) @function.method.call))

(function_declaration
  name: (identifier) @function)

(method_declaration
  name: (field_identifier) @function.method)

(method_elem
  name: (field_identifier) @function.method)

((identifier) @function.builtin
  (#any-of? @function.builtin
    "append" "cap" "clear" "close" "complex" "copy" "delete" "imag" "len" "make" "max" "min" "new"
    "panic" "print" "println" "real" "recover"))

; Delimiters
("." @punctuation.delimiter
	(#not-has-parent? @punctuation.delimiter qualified_type))

"," @punctuation.delimiter

":" @punctuation.delimiter

";" @punctuation.delimiter.semicolon

"(" @punctuation.bracket

")" @punctuation.bracket

"{" @punctuation.bracket

"}" @punctuation.bracket

"[" @punctuation.bracket

"]" @punctuation.bracket

; Literals
(interpreted_string_literal) @string

(raw_string_literal) @string

(rune_literal) @string

(escape_sequence) @string.escape

(int_literal) @number

(float_literal) @number.float

(imaginary_literal) @number

[
  (true)
  (false)
] @boolean

[
  (nil)
  (iota)
] @constant.builtin

(keyed_element
  .
  (literal_element
    (identifier) @variable.member))

(field_declaration
  name: (field_identifier) @variable.member)

; Comments
(comment) @comment @spell

; Doc Comments
(source_file
  .
  (comment)+ @comment.documentation)

(source_file
  (comment)+ @comment.documentation
  .
  (const_declaration))

(source_file
  (comment)+ @comment.documentation
  .
  (function_declaration))

(source_file
  (comment)+ @comment.documentation
  .
  (type_declaration))

(source_file
  (comment)+ @comment.documentation
  .
  (var_declaration))

; Spell
((interpreted_string_literal) @spell
  (#not-has-parent? @spell import_spec))

; Regex
(call_expression
  (selector_expression) @_function
  (#any-of? @_function
    "regexp.Match" "regexp.MatchReader" "regexp.MatchString" "regexp.Compile" "regexp.CompilePOSIX"
    "regexp.MustCompile" "regexp.MustCompilePOSIX")
  (argument_list
    .
    [
      (raw_string_literal
        (raw_string_literal_content) @string.regexp)
      (interpreted_string_literal
        (interpreted_string_literal_content) @string.regexp)
    ]))

; Formatting
; (call_expression
  ; (selector_expression
		; (identifier) @_identifier
		; (field_identifier) @_field_identifier)
	; (#match? @_identifier "fmt")
  ; (#any-of? @_field_identifier
    ; "Printf" "Scanf" "Sprintf")
  ; (argument_list
    ; .
    ; [
      ; (interpreted_string_literal
        ; (interpreted_string_literal_content) @formatting
				; (#match? @formatting "%[sdf]"))
    ; ]))
