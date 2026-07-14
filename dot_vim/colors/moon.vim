" Moon Colorscheme for Vim (Ported from neomodern.nvim)
set termguicolors
hi clear
syntax reset
let g:colors_name = "moon"
set background=dark

" Palette
let s:bg       = "#151515"
let s:fg       = "#a0a0ab"
let s:comment  = "#4c4c57"
let s:blue     = "#7a8aa6"
let s:green    = "#777d77"
let s:red      = "#b39066"
let s:yellow   = "#b5b3a5"
let s:magenta  = "#817882"
let s:cyan     = "#6d748c"
let s:func     = "#5c6b8a"
let s:visual   = "#24242b"
let s:line     = "#1a1a21"

" Helper function for highlights
function! s:h(group, fg, bg, attr)
    let l_fg = a:fg != 'NONE' ? 'guifg=' . a:fg : ''
    let l_bg = a:bg != 'NONE' ? 'guibg=' . a:bg : ''
    let l_attr = a:attr != 'NONE' ? 'gui=' . a:attr : ''
    execute 'hi ' . a:group . ' ' . l_fg . ' ' . l_bg . ' ' . l_attr
endfunction

call s:h('Normal', s:fg, s:bg, 'NONE')
call s:h('Pmenu', s:fg, s:visual, 'NONE')
call s:h('SignColumn', s:bg, s:bg, 'NONE')
call s:h('Title', s:blue, 'NONE', 'bold')
call s:h('LineNr', s:comment, 'NONE', 'NONE')
call s:h('NonText', s:comment, 'NONE', 'NONE')
call s:h('Comment', s:comment, 'NONE', 'italic')
call s:h('CursorLine', 'NONE', s:line, 'NONE')
call s:h('TabLineFill', 'NONE', 'NONE', 'NONE')
call s:h('TabLine', s:comment, s:visual, 'NONE')
call s:h('StatusLine', s:fg, s:visual, 'bold')
call s:h('StatusLineNC', s:comment, 'NONE', 'NONE')
call s:h('Search', s:bg, s:blue, 'NONE')
call s:h('VertSplit', s:bg, s:bg, 'NONE')
call s:h('Visual', s:fg, s:visual, 'NONE')
call s:h('MatchParen', s:bg, s:blue, 'bold')

call s:h('DiffText', s:fg, s:blue, 'NONE')
call s:h('ErrorMsg', s:red, 'NONE', 'bold')
call s:h('WarningMsg', s:yellow, 'NONE', 'NONE')
call s:h('PreProc', s:blue, 'NONE', 'NONE')
call s:h('Exception', s:red, 'NONE', 'NONE')
call s:h('Error', s:red, 'NONE', 'bold')
call s:h('DiffDelete', s:red, 'NONE', 'NONE')

call s:h('Type', s:cyan, 'NONE', 'NONE')
call s:h('Identifier', s:magenta, 'NONE', 'NONE')
call s:h('Constant', s:yellow, 'NONE', 'NONE')
call s:h('Repeat', s:yellow, 'NONE', 'NONE')
call s:h('Keyword', s:blue, 'NONE', 'NONE')
call s:h('IncSearch', s:bg, s:blue, 'NONE')
call s:h('Conditional', s:blue, 'NONE', 'NONE')
call s:h('Todo', s:yellow, 'NONE', 'bold')
call s:h('Special', s:magenta, 'NONE', 'NONE')
call s:h('Number', s:red, 'NONE', 'NONE')
call s:h('String', s:green, 'NONE', 'NONE')
call s:h('Function', s:func, 'NONE', 'NONE')
call s:h('Statement', s:blue, 'NONE', 'NONE')
call s:h('Operator', s:cyan, 'NONE', 'NONE')
call s:h('Directory', s:blue, 'NONE', 'NONE')

" End of moon colorscheme
