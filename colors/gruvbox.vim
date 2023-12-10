scriptencoding utf-8

" -----------------------------------------------------------------------------
" File: gruvbox.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/gruvbox-community/gruvbox
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if v:version > 580
  hi clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name='gruvbox'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:gruvbox_bold')
  let g:gruvbox_bold=1
endif
if !exists('g:gruvbox_italic')
  if has('gui_running') || $TERM_ITALICS ==# 'true'
    let g:gruvbox_italic=1
  else
    let g:gruvbox_italic=0
  endif
endif
if !exists('g:gruvbox_undercurl')
  let g:gruvbox_undercurl=1
endif
if !exists('g:gruvbox_underline')
  let g:gruvbox_underline=1
endif
if !exists('g:gruvbox_inverse')
  let g:gruvbox_inverse=1
endif

if !exists('g:gruvbox_guisp_fallback') || index(['fg', 'bg'], g:gruvbox_guisp_fallback) == -1
  let g:gruvbox_guisp_fallback='NONE'
endif

if !exists('g:gruvbox_improved_strings')
  let g:gruvbox_improved_strings=0
endif

if !exists('g:gruvbox_improved_warnings')
  let g:gruvbox_improved_warnings=0
endif

if !exists('g:gruvbox_termcolors')
  let g:gruvbox_termcolors=256
endif

if !exists('g:gruvbox_invert_indent_guides')
  let g:gruvbox_invert_indent_guides=0
endif

if exists('g:gruvbox_contrast')
  echo 'g:gruvbox_contrast is deprecated; use g:gruvbox_contrast_light and g:gruvbox_contrast_dark instead'
endif

if !exists('g:gruvbox_contrast_dark')
  let g:gruvbox_contrast_dark='medium'
endif

if !exists('g:gruvbox_contrast_light')
  let g:gruvbox_contrast_light='medium'
endif

if !exists('g:gruvbox_treesitter')
  let g:gruvbox_treesitter=has('nvim-0.7.3')
endif

let s:is_dark=(&background ==# 'dark')

" }}}
" Palette Utility Functions: {{{

function! s:Color(name, default, ...)
  " color already set, validate option
  if has_key(s:gb, a:name)
    let l:color = s:gb[a:name]

    if type(l:color) == type('')
      " gui color only
      let s:gb[a:name] = copy(a:default)
      let s:gb[a:name][0] = l:color
      return 1
    elseif type(l:color) == type(0)
      " terminal color only
      let s:gb[a:name] = copy(a:default)
      let s:gb[a:name][1] = l:color
      return 1
    elseif type(l:color) == type([])
          \ && len(l:color) == 2
          \ && type(l:color[0]) == type('')
          \ && type(l:color[1]) == type(0)
      " gui and terminal color
      return 1
    else
      " invalid value
      echo a:name 'is invalid, usage: let g:gruvbox_colors.color = (["#ffffff", 255]|"#ffffff"|255)'
      return 0
    endif

  endif

  " set default option
  let s:gb[a:name] = a:default
  return 1
endfunction

" }}}
" Palette: {{{

" get the global gruvbox palette options, if any
let g:gruvbox_colors = get(g:, 'gruvbox_colors', {})
" initialize the script palette
let s:gb = copy(g:gruvbox_colors)
let g:current_gruvbox_colors = s:gb

" set palette default colors
call s:Color('dark0_hard',  ['#1d2021', 234])     " 29-32-33
call s:Color('dark0',       ['#282828', 235])     " 40-40-40
call s:Color('dark0_soft',  ['#32302f', 236])     " 50-48-47
call s:Color('dark1',       ['#3c3836', 237])     " 60-56-54
call s:Color('dark2',       ['#504945', 239])     " 80-73-69
call s:Color('dark3',       ['#665c54', 241])     " 102-92-84
call s:Color('dark4',       ['#7c6f64', 243])     " 124-111-100
call s:Color('dark4_256',   ['#7c6f64', 243])     " 124-111-100

call s:Color('gray_245',    ['#928374', 245])     " 146-131-116
call s:Color('gray_244',    ['#928374', 244])     " 146-131-116

call s:Color('light0_hard', ['#f9f5d7', 230])     " 249-245-215
call s:Color('light0',      ['#fbf1c7', 229])     " 253-244-193
call s:Color('light0_soft', ['#f2e5bc', 228])     " 242-229-188
call s:Color('light1',      ['#ebdbb2', 223])     " 235-219-178
call s:Color('light2',      ['#d5c4a1', 250])     " 213-196-161
call s:Color('light3',      ['#bdae93', 248])     " 189-174-147
call s:Color('light4',      ['#a89984', 246])     " 168-153-132
call s:Color('light4_256',  ['#a89984', 246])     " 168-153-132

call s:Color('bright_red',     ['#fb4934', 167])     " 251-73-52
call s:Color('bright_green',   ['#b8bb26', 142])     " 184-187-38
call s:Color('bright_yellow',  ['#fabd2f', 214])     " 250-189-47
call s:Color('bright_blue',    ['#83a598', 109])     " 131-165-152
call s:Color('bright_purple',  ['#d3869b', 175])     " 211-134-155
call s:Color('bright_aqua',    ['#8ec07c', 108])     " 142-192-124
call s:Color('bright_orange',  ['#fe8019', 208])     " 254-128-25

call s:Color('neutral_red',    ['#cc241d', 124])     " 204-36-29
call s:Color('neutral_green',  ['#98971a', 106])     " 152-151-26
call s:Color('neutral_yellow', ['#d79921', 172])     " 215-153-33
call s:Color('neutral_blue',   ['#458588', 66])      " 69-133-136
call s:Color('neutral_purple', ['#b16286', 132])     " 177-98-134
call s:Color('neutral_aqua',   ['#689d6a', 72])      " 104-157-106
call s:Color('neutral_orange', ['#d65d0e', 166])     " 214-93-14

call s:Color('faded_red',      ['#9d0006', 88])      " 157-0-6
call s:Color('faded_green',    ['#79740e', 100])     " 121-116-14
call s:Color('faded_yellow',   ['#b57614', 136])     " 181-118-20
call s:Color('faded_blue',     ['#076678', 24])      " 7-102-120
call s:Color('faded_purple',   ['#8f3f71', 96])      " 143-63-113
call s:Color('faded_aqua',     ['#427b58', 65])      " 66-123-88
call s:Color('faded_orange',   ['#af3a03', 130])     " 175-58-3

call s:Color('none', ['NONE','NONE'])
call s:Color('NONE', ['NONE','NONE'])
call s:Color('None', ['NONE','NONE'])

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:gruvbox_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:gruvbox_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:gruvbox_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:gruvbox_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:gruvbox_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0 = s:gb.dark0
  if g:gruvbox_contrast_dark ==# 'soft'
    let s:bg0 = s:gb.dark0_soft
  elseif g:gruvbox_contrast_dark ==# 'hard'
    let s:bg0 = s:gb.dark0_hard
  endif

  let s:bg1 = s:gb.dark1
  let s:bg2 = s:gb.dark2
  let s:bg3 = s:gb.dark3
  let s:bg4 = s:gb.dark4

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0 = s:gb.light0
  if g:gruvbox_contrast_light ==# 'soft'
    let s:bg0 = s:gb.light0_soft
  elseif g:gruvbox_contrast_light ==# 'hard'
    let s:bg0 = s:gb.light0_hard
  endif

  let s:bg1 = s:gb.light1
  let s:bg2 = s:gb.light2
  let s:bg3 = s:gb.light3
  let s:bg4 = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:purple = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:gruvbox_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
call s:Color('bg0', s:bg0)
call s:Color('bg1', s:bg1)
call s:Color('bg2', s:bg2)
call s:Color('bg3', s:bg3)
call s:Color('bg4', s:bg4)

call s:Color('gray', s:gray)

call s:Color('fg0', s:fg0)
call s:Color('fg1', s:fg1)
call s:Color('fg2', s:fg2)
call s:Color('fg3', s:fg3)
call s:Color('fg4', s:fg4)

call s:Color('fg4_256', s:fg4_256)

call s:Color('red',    s:red)
call s:Color('green',  s:green)
call s:Color('yellow', s:yellow)
call s:Color('blue',   s:blue)
call s:Color('purple', s:purple)
call s:Color('aqua',   s:aqua)
call s:Color('orange', s:orange)

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:gb.bg0[0]
  let g:terminal_color_8 = s:gb.gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:gb.red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:gb.green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:gb.yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:gb.blue[0]

  let g:terminal_color_5 = s:gb.neutral_purple[0]
  let g:terminal_color_13 = s:gb.purple[0]

  let g:terminal_color_6 = s:gb.neutral_aqua[0]
  let g:terminal_color_14 = s:gb.aqua[0]

  let g:terminal_color_7 = s:gb.fg4[0]
  let g:terminal_color_15 = s:gb.fg1[0]
endif

" }}}
" Setup Terminal Colors For Vim with termguicolors: {{{

if exists('*term_setansicolors')
  let g:terminal_ansi_colors = repeat([0], 16)

  let g:terminal_ansi_colors[0] = s:gb.bg0[0]
  let g:terminal_ansi_colors[8] = s:gb.gray[0]

  let g:terminal_ansi_colors[1] = s:gb.neutral_red[0]
  let g:terminal_ansi_colors[9] = s:gb.red[0]

  let g:terminal_ansi_colors[2] = s:gb.neutral_green[0]
  let g:terminal_ansi_colors[10] = s:gb.green[0]

  let g:terminal_ansi_colors[3] = s:gb.neutral_yellow[0]
  let g:terminal_ansi_colors[11] = s:gb.yellow[0]

  let g:terminal_ansi_colors[4] = s:gb.neutral_blue[0]
  let g:terminal_ansi_colors[12] = s:gb.blue[0]

  let g:terminal_ansi_colors[5] = s:gb.neutral_purple[0]
  let g:terminal_ansi_colors[13] = s:gb.purple[0]

  let g:terminal_ansi_colors[6] = s:gb.neutral_aqua[0]
  let g:terminal_ansi_colors[14] = s:gb.aqua[0]

  let g:terminal_ansi_colors[7] = s:gb.fg4[0]
  let g:terminal_ansi_colors[15] = s:gb.fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:gb.orange
if exists('g:gruvbox_hls_cursor')
  let s:hls_cursor = get(s:gb, g:gruvbox_hls_cursor)
endif

let s:hls_highlight = s:gb.yellow
if exists('g:gruvbox_hls_highlight')
  let s:hls_highlight = get(s:gb, g:gruvbox_hls_highlight)
endif

let s:number_column = s:none
if exists('g:gruvbox_number_column')
  let s:number_column = get(s:gb, g:gruvbox_number_column)
endif

let s:sign_column = s:gb.bg1
if exists('g:gruvbox_sign_column')
  let s:sign_column = get(s:gb, g:gruvbox_sign_column)
endif

let s:color_column = s:gb.bg1
if exists('g:gruvbox_color_column')
  let s:color_column = get(s:gb, g:gruvbox_color_column)
endif

let s:cursorline = s:gb.bg1
if exists('g:gruvbox_cursorline')
  let s:cursorline = get(s:gb, g:gruvbox_cursorline)
endif

let s:vert_split = s:gb.bg0
if exists('g:gruvbox_vert_split')
  let s:vert_split = get(s:gb, g:gruvbox_vert_split)
endif

let s:invert_signs = ''
if exists('g:gruvbox_invert_signs')
  if g:gruvbox_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:gruvbox_invert_selection')
  if g:gruvbox_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:gruvbox_invert_tabline')
  if g:gruvbox_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:tabline_sel = s:gb.green
if exists('g:gruvbox_tabline_sel')
  let s:tabline_sel = get(s:gb, g:gruvbox_tabline_sel)
endif

let s:italicize_comments = s:italic
if exists('g:gruvbox_italicize_comments')
  if g:gruvbox_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:gruvbox_italicize_strings')
  if g:gruvbox_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

let s:italicize_operators = ''
if exists('g:gruvbox_italicize_operators')
  if g:gruvbox_italicize_operators == 1
    let s:italicize_operators = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:gruvbox_guisp_fallback !=# 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:gruvbox_guisp_fallback ==# 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Gruvbox Hi Groups: {{{

" memoize common hi groups
call s:HL('GruvboxFg0', s:gb.fg0)
call s:HL('GruvboxFg1', s:gb.fg1)
call s:HL('GruvboxFg2', s:gb.fg2)
call s:HL('GruvboxFg3', s:gb.fg3)
call s:HL('GruvboxFg4', s:gb.fg4)
call s:HL('GruvboxGray', s:gb.gray)
call s:HL('GruvboxBg0', s:gb.bg0)
call s:HL('GruvboxBg1', s:gb.bg1)
call s:HL('GruvboxBg2', s:gb.bg2)
call s:HL('GruvboxBg3', s:gb.bg3)
call s:HL('GruvboxBg4', s:gb.bg4)

call s:HL('GruvboxRed', s:gb.red)
call s:HL('GruvboxRedBold', s:gb.red, s:none, s:bold)
call s:HL('GruvboxGreen', s:gb.green)
call s:HL('GruvboxGreenBold', s:gb.green, s:none, s:bold)
call s:HL('GruvboxYellow', s:gb.yellow)
call s:HL('GruvboxYellowBold', s:gb.yellow, s:none, s:bold)
call s:HL('GruvboxBlue', s:gb.blue)
call s:HL('GruvboxBlueBold', s:gb.blue, s:none, s:bold)
call s:HL('GruvboxPurple', s:gb.purple)
call s:HL('GruvboxPurpleBold', s:gb.purple, s:none, s:bold)
call s:HL('GruvboxAqua', s:gb.aqua)
call s:HL('GruvboxAquaBold', s:gb.aqua, s:none, s:bold)
call s:HL('GruvboxOrange', s:gb.orange)
call s:HL('GruvboxOrangeBold', s:gb.orange, s:none, s:bold)

call s:HL('GruvboxRedSign', s:gb.red, s:sign_column, s:invert_signs)
call s:HL('GruvboxGreenSign', s:gb.green, s:sign_column, s:invert_signs)
call s:HL('GruvboxYellowSign', s:gb.yellow, s:sign_column, s:invert_signs)
call s:HL('GruvboxBlueSign', s:gb.blue, s:sign_column, s:invert_signs)
call s:HL('GruvboxPurpleSign', s:gb.purple, s:sign_column, s:invert_signs)
call s:HL('GruvboxAquaSign', s:gb.aqua, s:sign_column, s:invert_signs)
call s:HL('GruvboxOrangeSign', s:gb.orange, s:sign_column, s:invert_signs)

call s:HL('GruvboxRedUnderline', s:none, s:none, s:undercurl, s:gb.red)
call s:HL('GruvboxGreenUnderline', s:none, s:none, s:undercurl, s:gb.green)
call s:HL('GruvboxYellowUnderline', s:none, s:none, s:undercurl, s:gb.yellow)
call s:HL('GruvboxBlueUnderline', s:none, s:none, s:undercurl, s:gb.blue)
call s:HL('GruvboxPurpleUnderline', s:none, s:none, s:undercurl, s:gb.purple)
call s:HL('GruvboxAquaUnderline', s:none, s:none, s:undercurl, s:gb.aqua)
call s:HL('GruvboxOrangeUnderline', s:none, s:none, s:undercurl, s:gb.orange)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:gb.fg1, s:gb.bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/gruvbox/issues/7
if exists('v:vim_did_enter')
  let g:gruvbox_vim_did_enter = v:vim_did_enter
else
  augroup GruvboxVimEnter
    au!
    autocmd VimEnter * let g:gruvbox_vim_did_enter = 1
  augroup End
endif
if get(g:, 'gruvbox_vim_did_enter', 0)
  if s:is_dark
    set background=dark
  else
    set background=light
  endif
endif

if v:version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine', s:none, s:cursorline)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:gb.bg4, s:gb.bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:tabline_sel, s:gb.bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:gb.bg3, s:bold)
endif

if v:version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn', s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:gb.blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:gb.yellow, s:cursorline)
endif

hi! link NonText GruvboxBg2
hi! link SpecialKey GruvboxFg4

call s:HL('Visual', s:none, s:gb.bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search', s:hls_highlight, s:gb.bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:gb.bg0, s:inverse)

call s:HL('QuickFixLine', s:gb.bg0, s:gb.yellow, s:bold)

call s:HL('Underlined', s:fg3, s:none, s:underline)

call s:HL('StatusLine', s:gb.bg2, s:gb.fg1, s:inverse)
call s:HL('StatusLineNC', s:gb.bg1, s:gb.fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:gb.bg3, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:gb.blue, s:gb.bg2, s:bold)

" Directory names, special names in listing
hi! link Directory GruvboxGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title GruvboxGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',s:gb.bg0, s:gb.red, s:bold)
" More prompt: -- More --
hi! link MoreMsg GruvboxYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg GruvboxYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question GruvboxOrangeBold
" Warning messages
hi! link WarningMsg GruvboxRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:gb.bg4, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gb.gray, s:gb.bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gb.gray, s:gb.bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

" Special characters and variables
if g:gruvbox_improved_strings == 0
  hi! link Special GruvboxOrange
else
  call s:HL('Special', s:gb.orange, s:gb.bg1, s:italicize_strings)
endif

" Default comment color
call s:HL('Comment', s:gb.gray, s:none, s:italicize_comments)
" Comment message "TODO" keywords
call s:HL('Todo', s:vim_fg, s:none, s:bold . s:italic)
" Comment message "ERROR" keywords
call s:HL('Error', s:gb.red, s:none, s:bold . s:inverse)

" Link text
call s:HL('Link', s:gb.purple, s:none, s:underline)
" Heading text
hi! link H1 GruvboxGreenBold
hi! link H2 GruvboxGreenBold
hi! link H3 GruvboxGreen
hi! link H4 GruvboxGreen
hi! link H5 GruvboxGreen
hi! link H6 GruvboxGreen
" Example code in comments
hi! link CodeBlock GruvboxAqua
" Quote text
hi! link Quote GruvboxFg3
" Normal text
hi! link Text GruvboxFg1

" Generic statement
hi! link Statement GruvboxRed
" if, then, else, endif, switch, etc.
hi! link Conditional GruvboxRed
" for, do, while, etc.
hi! link Repeat GruvboxRed
" case, default, etc.
hi! link Label GruvboxRed
" try, catch, throw
hi! link Exception GruvboxRed
" sizeof, "+", "*", etc.
call s:HL('Operator', s:gb.orange, s:none, s:italicize_operators)
" Punctuation
hi! link Punctuation GruvboxBlue
hi! link Delimiter Punctuation
hi! link Bracket Punctuation
hi! link Noise Punctuation
" Any other keyword
hi! link Keyword GruvboxRed

" Variable name
hi! link Identifier GruvboxFg1
" Field/attribute names
hi! link Field GruvboxAqua
" Tag names
hi! link Tag GruvboxGreen
" Function name
hi! link Function GruvboxGreenBold

" Generic preprocessor
hi! link PreProc GruvboxAqua
" Preprocessor #include
hi! link Include GruvboxAqua
" Preprocessor #define
hi! link Define GruvboxAqua
" Same as Define
hi! link Macro GruvboxAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit GruvboxAqua

" Generic constant
hi! link Constant GruvboxPurple
" Character constant: 'c', '/n'
hi! link Character GruvboxPurple
" String constant: "this is a string"
if g:gruvbox_improved_strings == 0
  call s:HL('String', s:gb.green, s:none, s:italicize_strings)
else
  call s:HL('String', s:gb.fg1, s:gb.bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean GruvboxPurple
" Number constant: 234, 0xff
hi! link Number GruvboxPurple
" Floating point constant: 2.3e10
hi! link Float GruvboxPurple

" Generic type
hi! link Type GruvboxYellow
" static, register, volatile, etc
hi! link StorageClass GruvboxYellow
" struct, union, enum, etc.
hi! link Structure GruvboxYellow
" typedef
hi! link Typedef GruvboxYellow

" }}}
" Completion Menu: {{{

if v:version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:gb.fg1, s:gb.bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:gb.bg2, s:gb.blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:gb.bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:gb.bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:gb.red, s:gb.bg0, s:inverse)
call s:HL('DiffAdd',    s:gb.green, s:gb.bg0, s:inverse)
"call s:HL('DiffChange', s:gb.bg0, s:gb.blue)
"call s:HL('DiffText',   s:gb.bg0, s:gb.yellow)

" Alternative setting
call s:HL('DiffChange', s:gb.aqua, s:gb.bg0, s:inverse)
call s:HL('DiffText',   s:gb.yellow, s:gb.bg0, s:inverse)

" }}}
" Spelling: {{{

if has('spell')
  " Not capitalised word, or compile warnings
  if g:gruvbox_improved_warnings == 0
    hi! link SpellCap GruvboxBlueUnderline
  else
    call s:HL('SpellCap', s:gb.green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  hi! link SpellBad GruvboxRedUnderline
  " Wrong spelling for selected region
  hi! link SpellLocal GruvboxAquaUnderline
  " Rare word
  hi! link SpellRare GruvboxPurpleUnderline
endif

" }}}
" LSP: {{{

if has('nvim')
  hi! link DiagnosticError GruvboxRed
  hi! link DiagnosticSignError GruvboxRedSign
  hi! link DiagnosticUnderlineError GruvboxRedUnderline

  hi! link DiagnosticWarn GruvboxYellow
  hi! link DiagnosticSignWarn GruvboxYellowSign
  hi! link DiagnosticUnderlineWarn GruvboxYellowUnderline

  hi! link DiagnosticInfo GruvboxBlue
  hi! link DiagnosticSignInfo GruvboxBlueSign
  hi! link DiagnosticUnderlineInfo GruvboxBlueUnderline

  hi! link DiagnosticHint GruvboxAqua
  hi! link DiagnosticSignHint GruvboxAquaSign
  hi! link DiagnosticUnderlineHint GruvboxAquaUnderline

  hi! link LspReferenceText GruvboxYellowBold
  hi! link LspReferenceRead GruvboxYellowBold
  hi! link LspReferenceWrite GruvboxOrangeBold

  hi! link LspCodeLens GruvboxGray

  " Backward Compatibilty prior to (https://github.com/neovim/neovim/pull/15585)
  hi! link LspDiagnosticsDefaultError GruvboxRed
  hi! link LspDiagnosticsSignError GruvboxRedSign
  hi! link LspDiagnosticsUnderlineError GruvboxRedUnderline

  hi! link LspDiagnosticsDefaultWarning GruvboxYellow
  hi! link LspDiagnosticsSignWarning GruvboxYellowSign
  hi! link LspDiagnosticsUnderlineWarning GruvboxYellowUnderline

  hi! link LspDiagnosticsDefaultInformation GruvboxBlue
  hi! link LspDiagnosticsSignInformation GruvboxBlueSign
  hi! link LspDiagnosticsUnderlineInformation GruvboxBlueUnderline

  hi! link LspDiagnosticsDefaultHint GruvboxAqua
  hi! link LspDiagnosticsSignHint GruvboxAquaSign
  hi! link LspDiagnosticsUnderlineHint GruvboxAquaUnderline
endif

" LSP highlighting
if g:gruvbox_treesitter
  hi! link @lsp.type.member Function
  hi! link @lsp.type.property Field
  hi! link @lsp.typemod.variable.defaultLibrary @variable.builtin
endif

" }}}
" Treesitter: {{{

if g:gruvbox_treesitter
  hi! link @comment Comment
  hi! link @error Error
  hi! link @none NONE
  hi! link @preproc PreProc
  hi! link @define Define
  hi! link @operator Operator

  hi! link @punctuation Punctuation
  hi! link @punctuation.delimiter Delimiter
  hi! link @punctuation.bracket Bracket
  "hi! link @punctuation.special Special

  hi! link @string String
  "hi! link @string.regex String
  hi! link @string.escape Special
  "hi! link @string.special Special

  hi! link @character Character
  hi! link @character.special Special

  hi! link @boolean Boolean
  hi! link @number Number
  hi! link @float Float

  hi! link @function Function
  "hi! link @function.builtin Special
  "hi! link @function.call Special
  hi! link @function.macro Macro

  hi! link @method Function
  hi! link @method.call Function

  hi! link @constructor Function
  hi! link @parameter Identifier

  hi! link @keyword Keyword
  "hi! link @keyword.function Function
  "hi! link @keyword.operator Operator
  "hi! link @keyword.return Special

  hi! link @conditional Conditional
  hi! link @conditional.ternary Operator
  hi! link @repeat Repeat
  hi! link @debug Debug
  hi! link @label Label
  " Fix JSON fields appearing as labels (supposed to be "case", "default", etc.)
  hi! link @label.json Field
  hi! link @include Include
  hi! link @exception Exception

  hi! link @type Type
  "hi! link @type.builtin Type
  "hi! link @type.qualifier Type
  hi! link @type.definition Typedef

  hi! link @storageclass StorageClass
  hi! link @attribute PreProc
  hi! link @field Field
  hi! link @property Field

  hi! link @variable Identifier
  hi! link @variable.builtin Special

  hi! link @constant Constant
  "hi! link @constant.builtin Special
  hi! link @constant.macro Macro

  hi! link @namespace Include
  "hi! link @symbol Identifier

  hi! link @text Text
  hi! link @text.strong Bold
  hi! link @text.emphasis Bold
  hi! link @text.underline Underlined
  hi! link @text.strike Strikethrough
  hi! link @text.title Title
  hi! link @text.literal String
  hi! link @text.uri Link
  hi! link @text.math Special
  hi! link @text.environment PreProc
  hi! link @text.environment.name Delimiter
  hi! link @text.reference Identifier

  hi! link @text.todo Todo
  hi! link @text.note SpecialComment
  hi! link @text.danger Error
  hi! link @text.warning WarningMsg

  hi! link @tag Tag
  hi! link @tag.attribute Field
  hi! link @tag.delimiter Delimiter
endif

" }}}

" Plugin specific -------------------------------------------------------------
" Fugitive: {{{

hi! link fugitiveHash GruvboxBlue

" }}}
" EasyMotion: {{{

hi! link EasyMotionTarget GruvboxRedBold
hi! link EasyMotionTarget2First GruvboxYellowBold
hi! link EasyMotionTarget2Second GruvboxOrangeBold
hi! link EasyMotionShade GruvboxGray

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:gruvbox_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:gb.bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:gb.bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:gb.bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:gb.bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:gb.bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:gb.bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd GruvboxGreenSign
hi! link GitGutterChange GruvboxAquaSign
hi! link GitGutterDelete GruvboxRedSign
hi! link GitGutterChangeDelete GruvboxAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile GruvboxGreen
hi! link gitcommitDiscardedFile GruvboxRed

" }}}
" Signify: {{{

hi! link SignifySignAdd GruvboxGreenSign
hi! link SignifySignChange GruvboxAquaSign
hi! link SignifySignDelete GruvboxRedSign

" }}}
" gitsigns.nvim {{{

hi! link GitSignsAdd GruvboxGreenSign
hi! link GitSignsChange GruvboxOrangeSign
hi! link GitSignsDelete GruvboxRedSign

" }}}
" Syntastic: {{{

hi! link SyntasticError GruvboxRedUnderline
hi! link SyntasticWarning GruvboxYellowUnderline

hi! link SyntasticErrorSign GruvboxRedSign
hi! link SyntasticWarningSign GruvboxYellowSign

" }}}
" Termdebug: {{{

call s:HL('debugPC', s:none, s:gb.faded_blue)
hi! link debugBreakpoint GruvboxRedSign

" }}}
" Signature: {{{

hi! link SignatureMarkText   GruvboxBlueSign
hi! link SignatureMarkerText GruvboxPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl GruvboxBlueSign
hi! link ShowMarksHLu GruvboxBlueSign
hi! link ShowMarksHLo GruvboxBlueSign
hi! link ShowMarksHLm GruvboxBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch GruvboxYellow
hi! link CtrlPNoEntries GruvboxRed
hi! link CtrlPPrtBase GruvboxBg2
hi! link CtrlPPrtCursor GruvboxBlue
hi! link CtrlPLinePre GruvboxBg2

call s:HL('CtrlPMode1', s:gb.blue, s:gb.bg2, s:bold)
call s:HL('CtrlPMode2', s:gb.bg0, s:gb.blue, s:bold)
call s:HL('CtrlPStats', s:gb.fg4, s:gb.bg2, s:bold)

" }}}
" FZF: {{{

let g:fzf_colors = {
      \ 'fg':      ['fg', 'GruvboxFg1'],
      \ 'bg':      ['fg', 'GruvboxBg0'],
      \ 'hl':      ['fg', 'GruvboxYellow'],
      \ 'fg+':     ['fg', 'GruvboxFg1'],
      \ 'bg+':     ['fg', 'GruvboxBg1'],
      \ 'hl+':     ['fg', 'GruvboxYellow'],
      \ 'info':    ['fg', 'GruvboxBlue'],
      \ 'prompt':  ['fg', 'GruvboxFg4'],
      \ 'pointer': ['fg', 'GruvboxBlue'],
      \ 'marker':  ['fg', 'GruvboxOrange'],
      \ 'spinner': ['fg', 'GruvboxYellow'],
      \ 'header':  ['fg', 'GruvboxBg3']
      \ }

call s:HL('Fzf1', s:gb.blue, s:gb.bg1)
call s:HL('Fzf2', s:gb.orange, s:gb.bg1)
call s:HL('Fzf3', s:gb.fg4, s:gb.bg1)

" }}}
" Startify: {{{

hi! link StartifyBracket GruvboxFg3
hi! link StartifyFile GruvboxFg1
hi! link StartifyNumber GruvboxBlue
hi! link StartifyPath GruvboxGray
hi! link StartifySlash GruvboxGray
hi! link StartifySection GruvboxYellow
hi! link StartifySpecial GruvboxBg2
hi! link StartifyHeader GruvboxOrange
hi! link StartifyFooter GruvboxBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:gb.bg4[0], s:gb.red[0], s:gb.green[0], s:gb.yellow[0],
  \ s:gb.blue[0], s:gb.purple[0], s:gb.aqua[0], s:gb.fg4[0],
  \ s:gb.bg0[0], s:gb.red[0], s:gb.green[0], s:gb.orange[0],
  \ s:gb.blue[0], s:gb.purple[0], s:gb.aqua[0], s:gb.fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:gb.bg0, s:gb.fg4)
call s:HL('BufTabLineActive', s:gb.fg4, s:gb.bg2)
call s:HL('BufTabLineHidden', s:gb.bg4, s:gb.bg1)
call s:HL('BufTabLineFill', s:gb.bg0, s:gb.bg0)

" }}}
" Asynchronous Lint Engine: {{{

hi! link ALEError GruvboxRedUnderline
hi! link ALEWarning GruvboxYellowUnderline
hi! link ALEInfo GruvboxBlueUnderline

hi! link ALEErrorSign GruvboxRedSign
hi! link ALEWarningSign GruvboxYellowSign
hi! link ALEInfoSign GruvboxBlueSign

hi! link ALEVirtualTextError GruvboxRed
hi! link ALEVirtualTextWarning GruvboxYellow
hi! link ALEVirtualTextInfo GruvboxBlue

" }}}
" Dirvish: {{{

hi! link DirvishPathTail GruvboxAqua
hi! link DirvishArg GruvboxYellow

" }}}
" Netrw: {{{

hi! link netrwDir GruvboxAqua
hi! link netrwClassify GruvboxAqua
hi! link netrwLink GruvboxGray
hi! link netrwSymLink GruvboxFg1
hi! link netrwExe GruvboxYellow
hi! link netrwComment GruvboxGray
hi! link netrwList GruvboxBlue
hi! link netrwHelpCmd GruvboxAqua
hi! link netrwCmdSep GruvboxFg3
hi! link netrwVersion GruvboxGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir GruvboxAqua
hi! link NERDTreeDirSlash GruvboxAqua

hi! link NERDTreeOpenable GruvboxOrange
hi! link NERDTreeClosable GruvboxOrange

hi! link NERDTreeFile GruvboxFg1
hi! link NERDTreeExecFile GruvboxYellow

hi! link NERDTreeUp GruvboxGray
hi! link NERDTreeCWD GruvboxGreen
hi! link NERDTreeHelp GruvboxFg1

hi! link NERDTreeToggleOn GruvboxGreen
hi! link NERDTreeToggleOff GruvboxRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:gb.bg2)

" }}}
" coc.nvim: {{{

hi! link CocErrorSign GruvboxRedSign
hi! link CocWarningSign GruvboxOrangeSign
hi! link CocInfoSign GruvboxBlueSign
hi! link CocHintSign GruvboxAquaSign
hi! link CocErrorFloat GruvboxRed
hi! link CocWarningFloat GruvboxOrange
hi! link CocInfoFloat GruvboxBlue
hi! link CocHintFloat GruvboxAqua
hi! link CocDiagnosticsError GruvboxRed
hi! link CocDiagnosticsWarning GruvboxOrange
hi! link CocDiagnosticsInfo GruvboxBlue
hi! link CocDiagnosticsHint GruvboxAqua

hi! link CocSelectedText GruvboxRed
hi! link CocCodeLens GruvboxGray
hi! link CocSearch GruvboxAqua

hi! link CocErrorHighlight GruvboxRedUnderline
hi! link CocWarningHighlight GruvboxOrangeUnderline
hi! link CocInfoHighlight GruvboxBlueUnderline
hi! link CocHintHighlight GruvboxAquaUnderline

" }}}
" Telescope.nvim: {{{

hi! link TelescopeNormal GruvboxFg1
hi! link TelescopeSelection GruvboxOrangeBold
hi! link TelescopeSelectionCaret GruvboxRed
hi! link TelescopeMultiSelection GruvboxGray
hi! link TelescopeBorder TelescopeNormal
hi! link TelescopePromptBorder TelescopeNormal
hi! link TelescopeResultsBorder TelescopeNormal
hi! link TelescopePreviewBorder TelescopeNormal
hi! link TelescopeMatching GruvboxBlue
hi! link TelescopePromptPrefix GruvboxRed
hi! link TelescopePrompt TelescopeNormal

" }}}
" nvim-cmp: {{{

hi! link CmpItemAbbr GruvboxFg0
hi! link CmpItemAbbrDeprecated GruvboxFg1
hi! link CmpItemAbbrMatch GruvboxBlueBold
hi! link CmpItemAbbrMatchFuzzy GruvboxBlueUnderline
hi! link CmpItemMenu GruvboxGray
hi! link CmpItemKindText GruvboxOrange
hi! link CmpItemKindMethod GruvboxBlue
hi! link CmpItemKindFunction GruvboxBlue
hi! link CmpItemKindConstructor GruvboxYellow
hi! link CmpItemKindField GruvboxBlue
hi! link CmpItemKindClass GruvboxYellow
hi! link CmpItemKindInterface GruvboxYellow
hi! link CmpItemKindModule GruvboxBlue
hi! link CmpItemKindProperty GruvboxBlue
hi! link CmpItemKindValue GruvboxOrange
hi! link CmpItemKindEnum GruvboxYellow
hi! link CmpItemKindKeyword GruvboxPurple
hi! link CmpItemKindSnippet GruvboxGreen
hi! link CmpItemKindFile GruvboxBlue
hi! link CmpItemKindEnumMember GruvBoxAqua
hi! link CmpItemKindConstant GruvboxOrange
hi! link CmpItemKindStruct GruvboxYellow
hi! link CmpItemKindTypeParameter GruvboxYellow

"}}}
" Dashboard: {{{

hi! link DashboardHeader GruvboxYellowBold
hi! link DashboardCenter GruvboxGreen
hi! link DashboardCenterIcon GruvboxAqua
hi! link DashboardShortCut GruvboxBlue
hi! link DashboardFooter GruvboxPurple

" }}}

" Filetype specific -----------------------------------------------------------
" C#: {{{

hi! link csBraces Bracket
hi! link csEndColon Punctuation
hi! link csParens Bracket

hi! link csLogicSymbols Operator
hi! link csOpSymbols Operator
hi! link csStorage Keyword
hi! link csUnspecifiedStatement Statement

hi! link csInterpolationAlignDel Punctuation
hi! link csInterpolationDelimiter Punctuation
hi! link csInterpolationFormatDel Punctuation
hi! link csInterpolationFormat Special

" }}}
" Clojure: {{{

hi! link clojureStringEscape Special

" }}}
" CoffeeScript: {{{

hi! link coffeeBracket Bracket
hi! link coffeeCurly Bracket
hi! link coffeeExtendedOp Operator
hi! link coffeeObjAssign Field
hi! link coffeeObject Field
hi! link coffeeParen Bracket
hi! link coffeeSpecialOp Operator

" }}}
" CSS: {{{

hi! link cssClassName Tag
hi! link cssClassNameDot Operator
hi! link cssFunctionName Special
hi! link cssFunctionComma Special
hi! link cssIdentifier Identifier
hi! link cssImportant Keyword
hi! link cssPseudoClassId Tag

hi! link cssAttrComma Punctuation
hi! link cssAtRule Punctuation
hi! link cssBraces Punctuation
hi! link cssSelectorOp2 Punctuation
hi! link cssSelectorOp Punctuation

hi! link cssProp Field
hi! link cssVendor Field

" }}}
" Diff: {{{

hi! link diffAdded GruvboxGreen
hi! link diffRemoved GruvboxRed
hi! link diffChanged GruvboxAqua

hi! link diffFile GruvboxOrange
hi! link diffNewFile GruvboxYellow

hi! link diffLine GruvboxBlue

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter String
hi! link elixirInterpolationDelimiter Punctuation

hi! link elixirModuleDeclaration TypeDef

" }}}
" Go: {{{

hi! link goConst StorageClass
hi! link goImport Include
hi! link goParen Bracket

" }}}
" Haskell: {{{

hi! link haskellChar Character
hi! link haskellFloat Float
hi! link haskellNumber Number
hi! link haskellTH Boolean

hi! link haskellBottom Keyword
hi! link haskellDecl Keyword
hi! link haskellDeclKeyword Keyword
hi! link haskellDefault Keyword
hi! link haskellDeriveKeyword Keyword
hi! link haskellInfix Keyword
hi! link haskellKeyword Keyword
hi! link haskellLet Keyword
hi! link haskellPatternKeyword Keyword
hi! link haskellRecursiveDo Keyword
hi! link haskellTypeRoles Keyword
hi! link haskellWhere Keyword

hi! link haskellAssocType Type
hi! link haskellBacktick Special
hi! link haskellConditional Keyword
hi! link haskellDelimiter Delimiter
hi! link haskellForall Operator
hi! link haskellForeignKeywords Include
hi! link haskellIdentifier Identifier
hi! link haskellImportKeywords Include
hi! link haskellLiquid Comment
hi! link haskellOperators Operator
hi! link haskellPragma PreProc
hi! link haskellPreProc PreProc
hi! link haskellQuasiQuoted String
hi! link haskellQuotedType Type
hi! link haskellQuote String
hi! link haskellSeparator Punctuation
hi! link haskellShebang Comment
hi! link haskellType Type

" }}}
" Html: {{{

hi! link htmlTag Punctuation
hi! link htmlEndTag Punctuation

hi! link htmlTagName Tag
hi! link htmlArg Field

hi! link htmlTagN Normal
hi! link htmlSpecialTagName Special

call s:HL('htmlLink', s:gb.fg4, s:none, s:underline)

hi! link htmlSpecialChar Special

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Java: {{{

hi! link javaParen Bracket
hi! link javaParen1 javaParen
hi! link javaParen2 javaParen
hi! link javaParen3 javaParen
hi! link javaParen4 javaParen
hi! link javaParen5 javaParen

hi! link javaDocTags Keyword
hi! link javaDocParam Type

hi! link javaOperator Operator

" }}}
" Javascript: {{{

hi! link javaScriptBraces Bracket

" }}}
" Json: {{{

hi! link jsonBraces Punctuation
hi! link jsonKeyword Field
hi! link jsonKeywordMatch Punctuation
hi! link jsonQuote String
hi! link jsonString String

" }}}
" JSX: maxmellon/vim-jsx-pretty: {{{

hi! link jsxAttrib Field
hi! link jsxBraces Special
hi! link jsxComponentName Type
hi! link jsxEqual Operator
hi! link jsxTagName Tag

hi! link jsxClosePunct Punctuation
hi! link jsxCloseString Punctuation
hi! link jsxOpenPunct Punctuation

"}}}
" Lua: {{{

hi! link luaBraces Bracket
hi! link luaComma Punctuation
hi! link luaFuncKeyword Keyword
hi! link luaParen Bracket
hi! link luaStringLongTag Special
hi! link luaTable Bracket

" }}}
" Mail: {{{

" Override some defaults defined by mail.vim
" mail quoted text
hi! link mailQuoted1 GruvBoxAqua
hi! link mailQuoted2 GruvBoxPurple
hi! link mailQuoted3 GruvBoxYellow
hi! link mailQuoted4 GruvBoxGreen
hi! link mailQuoted5 GruvBoxRed
hi! link mailQuoted6 GruvBoxOrange

hi! link mailSignature Comment

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)
call s:HL('markdownBold', s:fg3, s:none, s:bold)
call s:HL('markdownBoldItalic', s:fg3, s:none, s:bold . s:italic)

hi! link markdownH1 H1
hi! link markdownH2 H2
hi! link markdownH3 H3
hi! link markdownH4 H4
hi! link markdownH5 H5
hi! link markdownH6 H6
hi! link markdownHeadingDelimiter GruvboxGreen

hi! link markdownCode CodeBlock
hi! link markdownCodeBlock CodeBlock
hi! link markdownCodeDelimiter Punctuation

hi! link markdownBlockquote Quote
hi! link markdownListMarker Punctuation
hi! link markdownOrderedListMarker Punctuation
hi! link markdownRule Punctuation
hi! link markdownHeadingRule Punctuation

hi! link markdownUrlDelimiter Punctuation
hi! link markdownLinkDelimiter Punctuation
hi! link markdownLinkTextDelimiter Punctuation

hi! link markdownUrl Link
hi! link markdownUrlTitleDelimiter Punctuation

hi! link markdownLinkText Identifier
hi! link markdownIdDeclaration Identifier

if g:gruvbox_treesitter
  hi link @text.title.1.marker.markdown Special
  hi link @text.title.2.marker.markdown Special
  hi link @text.title.3.marker.markdown Special
  hi link @text.title.4.marker.markdown Special
  hi link @text.title.5.marker.markdown Special
endif

" }}}
" MoonScript: {{{

hi! link moonFunction Punctuation
hi! link moonLuaFunc Function
hi! link moonObjAssign Field

" }}}
" ObjectiveC: {{{

hi! link objcDirective Keyword
hi! link objcObjDef Keyword
hi! link objcPropertyAttribute Field
hi! link objcTypeModifier GruvboxRed

" }}}
" Ocaml: {{{

hi! link ocamlArrow Operator
hi! link ocamlConstructor Type
hi! link ocamlInfixOpKeyword Keyword
hi! link ocamlKeyChar Operator
hi! link ocamlOperator Operator

" }}}
" PanglossJS: {{{

hi! link jsArrowFunction Punctuation
hi! link jsDocParam Field
hi! link jsDocTags Keyword
hi! link jsNull Special
hi! link jsObjectKey Field
hi! link jsObjectProp Field

" }}}
" PureScript: {{{

hi! link purescriptImportKeyword Include
hi! link purescriptModuleName Identifier

" }}}
" Python: {{{

hi! link pythonDecorator Operator
hi! link pythonDot Operator

" }}}
" Ruby: {{{

hi! link rubyDefinedOperator Keyword
hi! link rubyInterpolationDelimiter Macro
hi! link rubyStringDelimiter String

" }}}
" Rust: {{{

hi! link rustFoldBraces Bracket
hi! link rustSelf Special
hi! link rustSigil Operator

" }}}
" Scala: {{{

hi! link scalaCommentAnnotation Keyword
hi! link scalaCommentCodeBlock CodeBlock
hi! link scalaDocLinks Link
hi! link scalaMultilineComment Comment
hi! link scalaParamAnnotationValue Field
hi! link scalaParameterAnnotation Keyword
hi! link scalaShebang Comment
hi! link scalaTrailingComment Comment

hi! link scalaFString String
hi! link scalaFInterpolation Operator
hi! link scalaInterpolationBoundary Operator
hi! link scalaInterpolationBrackets String
hi! link scalaInterpolation Operator
hi! link scalaIString String
hi! link scalaString String
hi! link scalaTripleFString String
hi! link scalaTripleIString Operator
hi! link scalaTripleIString String
hi! link scalaTripleString String

hi! link scalaCapitalWord Type
hi! link scalaInstanceDeclaration Type
hi! link scalaTypeAnnotation Identifier
hi! link scalaTypeAnnotationParameter Special
hi! link scalaTypeDeclaration TypeDef
hi! link scalaTypeExtension Identifier
hi! link scalaTypeOperator Identifier
hi! link scalaTypePostExtension Operator
hi! link scalaTypeTypeExtension Identifier
hi! link scalaTypeTypePostDeclaration TypeDef
hi! link scalaTypeTypePostExtension Operator

hi! link scalaCaseFollowing Identifier
hi! link scalaExternal Include
hi! link scalaNameDefinition Identifier
hi! link scalaSquareBracketsBrackets Identifier
hi! link scalaSquareBrackets Identifier

hi! link scalaKeyword Keyword
hi! link scalaKeywordModifier Keyword

hi! link scalaAnnotation Special
hi! link scalaOperator Operator
hi! link scalaSpecial Special

hi! link scalaEscapedChar Special
hi! link scalaNumber Number

" }}}
" TypeScript: {{{

hi! link typescriptAssign Operator
hi! link typescriptBinaryOp Operator
hi! link typescriptCastKeyword Keyword
hi! link typescriptDocNotation Keyword
hi! link typescriptDocParam Field
hi! link typescriptDocTags Keyword
hi! link typescriptExport Include
hi! link typescriptImport Include
hi! link typescriptInterfaceName TypeDef
hi! link typescriptKeywordOp Operator
hi! link typescriptMember Field
hi! link typescriptObjectLabel Field
hi! link typescriptTernary Operator
hi! link typescriptVariable Type

hi! link typescriptAssign Punctuation
hi! link typescriptBraces Punctuation
hi! link typescriptEndColons Punctuation
hi! link typescriptObjectColon Punctuation
hi! link typescriptParens Punctuation
hi! link typescriptTypeAnnotation Punctuation

" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:gb.fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimCommand Keyword
hi! link vimMapModKey Special
hi! link vimNotation Special
hi! link vimOption Special
hi! link vimSet Normal
hi! link vimUsrCmd Macro
hi! link vimVar Variable

" Vim syntax is unable to highlight some punctuation at all.
" Make punctuation closer to the default white instead of the default color.

" hi! link vimBracket Punctuation
" hi! link vimContinue Punctuation
" hi! link vimEcho Punctuation
" hi! link vimFuncBody Punctuation
" hi! link vimOperParen Punctuation
" hi! link vimParenSep Punctuation
" hi! link vimSep Punctuation
" hi! link vimSetSep Punctuation

hi! link vimBracket GruvboxFg3
hi! link vimContinue GruvboxFg3
hi! link vimEcho GruvboxFg3
hi! link vimOperParen GruvboxFg3
hi! link vimParenSep GruvboxFg3
hi! link vimSep GruvboxFg3
hi! link vimSetSep GruvboxFg3

" Vim syntax is unable to highlight complete user functions calls/definitions.
" Make these appear the same as variables instead of the default color.

" hi! link vimFunction Function
" hi! link vimFuncSID Function
" hi! link vimUserFunc Function

hi! link vimFunction Variable
hi! link vimFuncSID Variable
hi! link vimUserFunc Variable

" }}}
" Xml: {{{

hi! link xmlTag Punctuation
hi! link xmlEndTag Punctuation
hi! link xmlTagName Tag
hi! link xmlEqual Operator

hi! link xmlDocType Field
hi! link xmlDocTypeDecl Punctuation
hi! link xmlDocTypeKeyword Special

hi! link xmlCdataStart Punctuation
hi! link xmlCdataEnd Punctuation
hi! link xmlCdataCdata Special
hi! link xmlCdata String

hi! link xmlAttrib Field
hi! link xmlProcessingDelim Punctuation
hi! link xmlAttribPunct Punctuation

hi! link xmlEntity Special
hi! link xmlEntityPunct Special

hi! link dtdAttrType Type
hi! link dtdCard Operator
hi! link dtdEnum Constant
hi! link dtdFunction Punctuation
hi! link dtdParamEntityDPunct Punctuation
hi! link dtdParamEntityPunct Punctuation
hi! link dtdString String
hi! link dtdTag Field
hi! link dtdTagName Special

hi! link docbkKeyword Tag
call s:HL('docbkTitle', s:vim_fg, s:vim_bg, s:bold)

" }}}
" YAJS: {{{

hi! link javascriptEndColons Punctuation
hi! link javascriptDocParam Identifier
hi! link javascriptDocNotation Keyword
hi! link javascriptDocParamName Field
hi! link javascriptDocParamType Type
hi! link javascriptDocTags Keyword
hi! link javascriptDocName Field
hi! link javascriptParens Bracket
hi! link javascriptBraces Bracket
hi! link javascriptBrackets Bracket
hi! link javascriptFuncArg Identifier
hi! link javascriptArrowFuncArg Identifier
hi! link javascriptArrowFunc Punctuation
hi! link javascriptVariable StorageClass
hi! link javascriptLabel Field
hi! link javascriptGlobal Special
hi! link javascriptOperator Operator
hi! link javascriptOpSymbol Operator
hi! link javascriptOpSymbols Operator
hi! link javascriptDotNotation Punctuation
hi! link javascriptComma Punctuation
hi! link javascriptObjectLabelColon Punctuation
hi! link javascriptNull Constant
hi! link javascriptIdentifierName Identifier
hi! link javascriptMethod Function
hi! link javascriptNumber Number
hi! link javascriptTemplateSubstitution Punctuation
hi! link javascriptParenObjectLiteral Bracket
hi! link javascriptParenTagLiteral Bracket

hi! link javascriptProp Field
hi! link javascriptBOMHistoryProp javascriptProp
hi! link javascriptBOMLocationProp javascriptProp
hi! link javascriptBOMNavigatorProp javascriptProp
hi! link javascriptBOMNetworkProp javascriptProp
hi! link javascriptBOMWindowProp javascriptProp
hi! link javascriptBroadcastProp javascriptProp
hi! link javascriptCryptoProp javascriptProp
hi! link javascriptDataViewProp javascriptProp
hi! link javascriptDOMDocProp javascriptProp
hi! link javascriptDOMEventProp javascriptProp
hi! link javascriptDOMFormProp javascriptProp
hi! link javascriptDOMNodeProp javascriptProp
hi! link javascriptDOMStorageProp javascriptProp
hi! link javascriptEncodingProp javascriptProp
hi! link javascriptES6MapProp javascriptProp
hi! link javascriptES6SetProp javascriptProp
hi! link javascriptFileReaderProp javascriptProp
hi! link javascriptMathStaticProp javascriptProp
hi! link javascriptNumberStaticProp javascriptProp
hi! link javascriptPaymentAddressProp javascriptProp
hi! link javascriptPaymentProp javascriptProp
hi! link javascriptPaymentResponseProp javascriptProp
hi! link javascriptPaymentShippingOptionProp javascriptProp
hi! link javascriptRegExpProp javascriptProp
hi! link javascriptRegExpStaticProp javascriptProp
hi! link javascriptRequestProp javascriptProp
hi! link javascriptResponseProp javascriptProp
hi! link javascriptServiceWorkerProp javascriptProp
hi! link javascriptSymbolProp javascriptProp
hi! link javascriptSymbolStaticProp javascriptProp
hi! link javascriptTypedArrayStaticProp javascriptProp
hi! link javascriptURLUtilsProp javascriptProp
hi! link javascriptXHRProp javascriptProp

" }}}

" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! GruvboxHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! GruvboxHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
