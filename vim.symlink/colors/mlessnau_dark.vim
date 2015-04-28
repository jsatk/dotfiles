set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "mlessnau_dark"

let s:blue    = "117"
let s:green1  = "64"
let s:green2  = "120"
let s:grey1   = "0"
let s:grey2   = "232"
let s:grey3   = "235"
let s:grey4   = "238"
let s:grey5   = "241"
let s:grey6   = "244"
let s:grey7   = "247"
let s:orange1 = "208"
let s:orange2 = "220"
let s:pink1   = "201"
let s:pink2   = "207"
let s:purple  = "147"
let s:red1    = "88"
let s:red2    = "9"
let s:red3    = "173"
let s:white   = "15"
let s:yellow  = "11"

function HiColor(grp, fg, bg, style)
  let hiCommand = "hi " . a:grp
  if a:fg != ""
    let hiCommand = hiCommand . " ctermfg=" . a:fg
  endif
  if a:bg != ""
    let hiCommand = hiCommand . " ctermbg=" . a:bg
  endif
  if a:style != ""
    let hiCommand = hiCommand . " cterm=" . a:style
  endif
  exec hiCommand
endfunction

" ### Global ##################################################################
call HiColor("Normal",                     s:white,   s:grey2,   "")
call HiColor("NonText",                    s:grey4,   s:grey2,   "")
call HiColor("Error",                      s:white,   s:red2,    "bold")

" ### Status Line & Wildmenu ##################################################
call HiColor("StatusLine",                 s:grey1,   s:white,   "bold")
call HiColor("StatusLineNC",               s:grey1,   s:grey5,   "none")
call HiColor("ModeMsg",                    s:grey1,   s:white,   "bold")
call HiColor("MoreMsg",                    s:grey1,   s:white,   "bold")
call HiColor("Question",                   s:grey1,   s:white,   "bold")
call HiColor("WildMenu",                   s:white,   s:pink1,   "bold")
call HiColor("Folded",                     s:grey2,   s:white,   "")
call HiColor("FoldColumn",                 s:red2,    s:grey1,   "")

" ### Search & Selection ######################################################
call HiColor("IncSearch",                  s:grey1,   s:orange2, "")
call HiColor("Search",                     s:grey1,   s:orange2, "")
call HiColor("Visual",                     s:grey1,   s:white,   "")

" ### Cursor ##################################################################
call HiColor("lCursor",                    s:white,   s:grey2,   "")
call HiColor("Cursor",                     s:white,   "",        "")
call HiColor("CursorColumn",               "",        s:grey3,   "")
call HiColor("CursorIM",                   s:white,   "",        "")
call HiColor("CursorLine",                 "",        s:grey3,   "none")

" ### Line/Column Helpers & Panes #############################################
call HiColor("ColorColumn",                "",        s:grey1,   "")
call HiColor("CursorLineNr",               s:white,   s:grey1,   "")
call HiColor("LineNr",                     s:grey5,   s:grey1,   "")
call HiColor("VertSplit",                  s:grey1,   s:grey1,   "")

" ### Directory Listing #######################################################
call HiColor("Directory",                  s:blue,    "",        "")

" ### Specials ######################## ########################################
call HiColor("Todo",                       s:white,   s:pink1,   "")
call HiColor("Title",                      s:white,   "",        "")
call HiColor("Special",                    s:red2,    "",        "bold")
call HiColor("Operator",                   s:white,   "",        "")
call HiColor("Delimiter",                  s:white,   "",        "")
call HiColor("SpecialKey",                 s:grey5,   "",        "")

" ### Syntax Elements #########################################################
call HiColor("String",                     s:green2,  "",       "")
call HiColor("Constant",                   s:blue,    "",       "")
call HiColor("Number",                     s:blue,    "",       "")
call HiColor("Statement",                  s:orange1, "",       "bold")
call HiColor("Function",                   s:orange2, "",       "")
call HiColor("PreProc",                    s:pink2,   "",       "bold")
call HiColor("Comment",                    s:grey6,   "",       "none")
call HiColor("SpecialComment",             s:grey6,   "",       "")
call HiColor("Type",                       s:orange1, "",       "bold")
call HiColor("Error",                      s:white,   s:red2,   "")
call HiColor("Identifier",                 s:white,   "",       "bold")
call HiColor("Keyword",                    s:orange1, "",       "")
"Label

" ### Messages ################################################################
call HiColor("ErrorMsg",                   s:white,   s:red2,   "bold")
call HiColor("WarningMsg",                 s:red2,    "",       "")

" ### Doxygen Related (C, C++, Java) ##########################################
call HiColor("doxygenSpecial",             s:grey7,   s:grey1,  "bold")
hi link doxygenBrief                Comment
hi link doxygenParam                doxygenSpecial
hi link doxygenParamName            Comment
hi link doxygenSpecialMultilineDesc Comment

" ### Python Related ##########################################################
"pythonCoding
"pythonRun
"pythonBuiltinObj
"pythonBuiltinFunc
"pythonException
"pythonExClass
"pythonSpaceError
"pythonDocTest
"pythonDocTest2
"pythonFunction
"pythonClass

" ### HTML Related ############################################################
call HiColor("htmlArg",                    s:orange2, "",       "bold")
call HiColor("htmlTag",                    s:orange1, "",       "")
call HiColor("htmlTagName",                s:orange1, "",       "bold")
call HiColor("htmlSpecialTag",             s:orange1, "",       "")
call HiColor("htmlSpecialTagName",         s:orange1, "",       "bold")
call HiColor("htmlEndTag",                 s:orange1, "",       "")
call HiColor("htmlBold",                   "",        "",       "bold")
call HiColor("htmlBoldItalic",             "",        "",       "bold,italic")
call HiColor("htmlBoldUnderline",          "",        "",       "underline")
call HiColor("htmlBoldUnderlineItalic",    "",        "",       "bold,underline,italic")
call HiColor("htmlItalic",                 "",        "",       "italic")
call HiColor("htmlLink",                   s:white,   "",       "")
call HiColor("htmlUnderline",              "",        "",       "underline")
call HiColor("htmlUnderlineItalic",        "",        "",       "underline,italic")

" ### Ruby Related ############################################################
call HiColor("rubyAccess",                 s:red2,    "",       "bold")
call HiColor("rubyBeginEnd",               s:orange1, "",       "bold")
call HiColor("rubyBlockParameter",         s:blue,    "",       "")
call HiColor("rubyClass",                  s:orange1, "",       "bold")
call HiColor("rubyConditional",            s:orange1, "",       "bold")
call HiColor("rubyConstant",               s:white,   "",       "bold")
call HiColor("rubyControl",                s:orange1, "",       "bold")
call HiColor("rubyDefine",                 s:orange1, "",       "bold")
call HiColor("rubyGlobalVariable",         s:yellow,  "",       "bold")
call HiColor("rubyInstanceVariable",       s:yellow,  "",       "")
call HiColor("rubyInterpolationDelimiter", s:pink2,   "",       "")
call HiColor("rubyKeyword",                s:orange1, "",       "bold")
call HiColor("rubyString",                 s:green2,  "",       "")
call HiColor("rubyStringDelimiter",        s:green2,  "",       "")
call HiColor("rubySymbol",                 s:blue,    "",       "")
call HiColor("rubyRegexp",                 s:pink2,   "",       "")
call HiColor("rubyRegexpDelimiter",        s:pink2,   "",       "")
call HiColor("rubyRegexpSpecial",          s:pink2,   "",       "")
call HiColor("rubyInclude",                s:orange1, "",       "bold")

" ### Vim Related #############################################################
call HiColor("vimCommand",                 s:orange1, "",       "bold")

" ### C/C++ Related ###########################################################
call HiColor("cConditional",               s:orange1, "",       "bold")
call HiColor("cppAccess",                  s:red2,    "",       "bold")

" ### PHP related #############################################################
call HiColor("phpClasses",                 s:white,   "",       "bold")
call HiColor("phpDefine",                  s:orange1, "",       "bold")
call HiColor("phpFunctions",               s:orange2, "",       "")
call HiColor("phpVarSelector",             s:purple,  "",       "")
call HiColor("phpIdentifier",              s:purple,  "",       "")
call HiColor("phpSpecialFunction",         s:orange2, "",       "")
call HiColor("phpAssignByRef",             s:white,   "",       "")
call HiColor("phpMemberSelector",          s:white,   "",       "")
call HiColor("phpComparison",              s:white,   "",       "")
call HiColor("phpSCKeyword",               s:red2,    "",       "bold")
call HiColor("phpDocTags",                 s:grey7,   "",       "bold")
call HiColor("phpDocParam",                s:grey7,   "",       "bold")

" ### JavaScript Related ######################################################
call HiColor("javaScript",                 s:white,   "",       "")
call HiColor("javaScriptFunction",         s:orange1, "",       "bold")
call HiColor("javaScriptLabel",            s:blue,    "",       "none")
call HiColor("javaScriptGlobalObjects",    s:white,   "",       "bold")
call HiColor("javaScriptDocTags",          s:grey7,   "",       "bold")
call HiColor("javaScriptOperator",         s:orange1, "",       "bold")
call HiColor("javaScriptRegexpString",     s:pink2,   "",       "")

" ### Pmenu ###################################################################
call HiColor("Pmenu",                      s:pink1,   s:grey1,  "bold")
call HiColor("PmenuSel",                   s:white,   s:pink1,  "bold")

" ### NERDTree ################################################################
call HiColor("NERDTreeCWD",                s:orange2, "",       "none")
call HiColor("NERDTreeRO",                 s:red2,    "",       "")
call HiColor("NERDTreeFlag",               s:white,   "",       "")

" ### Diff ####################################################################
call HiColor("DiffAdd",                    s:green1,  s:green2, "")
call HiColor("DiffDelete",                 s:red1,    s:red3,   "")
call HiColor("DiffChange",                 "",        s:grey2,  "")
"Ignore
"DiffText

