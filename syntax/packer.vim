" Forked from Larry Gilbert's syntax file
" github.com/L2G/vim-syntax-terraform

if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Identifiers are made up of alphanumeric characters, underscores, and
" hyphens.
if has('patch-7.4.1142')
    syn iskeyword a-z,A-Z,48-57,_,-
endif

syn case match

syn keyword packerSection variable locals build source provisioner post-processor source
syn keyword packerValueBool true false on off yes no

syn keyword packerTodo         contained TODO FIXME XXX BUG
syn region  packerComment      start="/\*" end="\*/" contains=packerTodo,@Spell
syn region  packerComment      start="#" end="$" contains=packerTodo,@Spell
syn region  packerComment      start="//" end="$" contains=packerTodo,@Spell

""" dynamic (HCL2)
syn keyword packerDynamic     dynamic nextgroup=packerDynamicName skipwhite
syn region  packerDynamicName start=/"/ end=/"/ nextgroup=packerDynamicBlock skipwhite

""" misc.
syn match packerValueDec      "\<[0-9]\+\([kKmMgG]b\?\)\?\>"
syn match packerValueHexaDec  "\<0x[0-9a-f]\+\([kKmMgG]b\?\)\?\>"
syn match packerBraces        "[\[\]]"

""" skip \" and \\ in strings.
syn region packerValueString   start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=packerStringInterp
syn region packerStringInterp  matchgroup=packerBraces start=/\${/ end=/}/ contained contains=ALL
syn region packerHereDocText   start=/<<-\?\z([a-z0-9A-Z]\+\)/ end=/^\s*\z1/ contains=packerStringInterp

"" Functions.
syn match packerValueFunction "[a-z0-9]\+(\@="

""" HCL2
syn keyword packerContent        content
syn keyword packerRepeat         for in
syn keyword packerConditional    if
syn keyword packerPrimitiveType  string bool number
syn keyword packerStructuralType object tuple
syn keyword packerCollectionType list map set
syn keyword packerValueNull      null

" enable block folding
syn region packerBlock matchgroup=packerBraces start="{" end="}" fold transparent

hi def link packerComment           Comment
hi def link packerBraces            Delimiter
hi def link packerSection           Structure
hi def link packerValueBool         Boolean
hi def link packerValueDec          Number
hi def link packerValueHexaDec      Number
hi def link packerValueString       String
hi def link packerHereDocText       String
hi def link packerValueFunction     Function
hi def link packerDynamic           Structure
hi def link packerDynamicName       String
hi def link packerContent           Structure
hi def link packerRepeat            Repeat
hi def link packerConditional       Conditional
hi def link packerPrimitiveType     Type
hi def link packerStructuralType    Type
hi def link packerCollectionType    Type
hi def link packerValueNull         Constant

let b:current_syntax = 'packer'

let &cpo = s:cpo_save
unlet s:cpo_save
