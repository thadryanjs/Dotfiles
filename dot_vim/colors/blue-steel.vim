" blue-steel colorscheme
set termguicolors
hi clear
syntax reset
let g:colors_name = "blue-steel"
set background=dark
set t_Co=256

hi Normal guifg=#b4b4b4 ctermbg=NONE guibg=#272935 gui=NONE
hi Pmenu guifg=#b4b4b4 guibg=#454545
hi SignColumn guibg=#272935
hi Title guifg=#b4b4b4
hi LineNr guifg=#747474 guibg=#272935
hi NonText guifg=#6c6b70 guibg=#272935
hi Comment guifg=#6c6b70 gui=italic
hi SpecialComment guifg=#6c6b70 gui=italic guibg=NONE
hi CursorLine guibg=#454545
hi TabLineFill gui=NONE guibg=#454545
hi TabLine guifg=#747474 guibg=#454545 gui=NONE
hi StatusLine gui=bold guibg=#454545 guifg=#b4b4b4
hi StatusLineNC gui=NONE guibg=#272935 guifg=#b4b4b4
hi Search guibg=#6c6b70 guifg=#b4b4b4
hi VertSplit gui=NONE guifg=#454545 guibg=NONE
hi Visual gui=NONE guibg=#454545
hi MatchParen cterm=bold ctermbg=14 guibg=#008080

hi DiffText guifg=#a0a0c2 guibg=NONE
hi ErrorMsg guifg=#a0a0c2 guibg=NONE
hi WarningMsg guifg=#a0a0c2 guibg=NONE
hi PreProc guifg=#a0a0c2 guibg=NONE
hi Exception guifg=#a0a0c2 guibg=NONE
hi Error guifg=#a0a0c2 guibg=NONE
hi DiffDelete guifg=#a0a0c2 guibg=NONE
hi GitGutterDelete guifg=#a0a0c2 guibg=NONE
hi GitGutterChangeDelete guifg=#a0a0c2 guibg=NONE
hi cssIdentifier guifg=#a0a0c2 guibg=NONE
hi cssImportant guifg=#a0a0c2 guibg=NONE
hi Type guifg=#a0a0c2 guibg=NONE
hi Identifier guifg=#a0a0c2 guibg=NONE
hi PMenuSel guifg=#bbb9b0 guibg=NONE
hi Constant guifg=#bbb9b0 guibg=NONE
hi Repeat guifg=#bbb9b0 guibg=NONE
hi DiffAdd guifg=#bbb9b0 guibg=NONE
hi GitGutterAdd guifg=#bbb9b0 guibg=NONE
hi cssIncludeKeyword guifg=#bbb9b0 guibg=NONE
hi Keyword guifg=#bbb9b0 guibg=NONE
hi IncSearch guifg=#778899 guibg=NONE
hi PreCondit guifg=#778899 guibg=NONE
hi Debug guifg=#778899 guibg=NONE
hi SpecialChar guifg=#778899 guibg=NONE
hi Conditional guifg=#778899 guibg=NONE
hi Todo guifg=#778899 guibg=NONE
hi Special guifg=#778899 guibg=NONE
hi Label guifg=#778899 guibg=NONE
hi Delimiter guifg=#778899 guibg=NONE
hi Number guifg=#778899 guibg=NONE
hi CursorLineNR guifg=#778899 guibg=NONE
hi Define guifg=#778899 guibg=NONE
hi MoreMsg guifg=#778899 guibg=NONE
hi Tag guifg=#778899 guibg=NONE
hi String guifg=#778899 guibg=NONE
hi Macro guifg=#778899 guibg=NONE
hi DiffChange guifg=#778899 guibg=NONE
hi GitGutterChange guifg=#778899 guibg=NONE
hi cssColor guifg=#778899 guibg=NONE
hi Function guifg=#d1d9e5 guibg=NONE
hi Directory guifg=#646476 guibg=NONE
hi markdownLinkText guifg=#646476 guibg=NONE
hi javaScriptBoolean guifg=#646476 guibg=NONE
hi Include guifg=#646476 guibg=NONE
hi Storage guifg=#646476 guibg=NONE
hi cssClassName guifg=#646476 guibg=NONE
hi cssClassNameDot guifg=#646476 guibg=NONE
hi Statement guifg=#3a6f9f guibg=NONE
hi Operator guifg=#3a6f9f guibg=NONE
hi cssAttr guifg=#3a6f9f guibg=NONE

" Clear background for other relevant groups
highlight Normal guibg=NONE ctermbg=NONE
highlight NonText guibg=NONE ctermbg=NONE
highlight MsgArea guibg=NONE ctermbg=NONE
highlight ModeMsg guibg=NONE ctermbg=NONE
highlight MoreMsg guibg=NONE ctermbg=NONE
highlight Question guibg=NONE ctermbg=NONE

" Terminal colors
let g:terminal_ansi_colors = [
  \'#282828', '#CC241D', '#98971A', '#D79921',
  \'#458588', '#B16286', '#689D6A', '#D65D0E',
  \'#fb4934', '#b8bb26', '#fabd2f', '#83a598',
  \'#d3869b', '#8ec07c', '#fe8019', '#FBF1C7' ]
