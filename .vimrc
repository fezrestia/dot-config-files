".vimrc

" Start of .vimrc
" Load local properties.
" Place ~/.vimrc_local file on local environment. (e.g. set background)
if filereadable(expand($HOME.'/.vimrc_local'))
    source $HOME/.vimrc_local
endif

" Only for VI IMproved.
set nocompatible

" Encoding
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8 " Encoding on file save.
set fileformats=unix,dos,mac " CR/LF auto detection.
set ambiwidth=double " Double byte glyph code.

" End of file control.
set nofixendofline " Do not add <EOL> after last line.

" Disable Key Mapping
nnoremap    ZZ          <Nop>
nnoremap    ZQ          <Nop>
nnoremap    J           <Nop>
nnoremap    K           <Nop>

" Tab
set tabstop=4  " tab width used for <Tab> char in file.
set expandtab
set shiftwidth=4  " used for indent.
set softtabstop=4  " used for <Tab> char input by user.

" Disable default indent behavior.
function! GetVimIndent()
    return -1 " Keep current indent.
endfunction
augroup updateIndentExpr
    autocmd!
    autocmd BufEnter * setlocal indentexpr=%!GetVimIndent()
augroup END

" Soft-wrap.
set breakindent
set breakindentopt=shift:8,sbr
set showbreak=->
set display=lastline  " show long line at end of buffer with tail @@@
set textwidth=0

" Control indent width by file extension.
augroup fileTypeIndent
    autocmd!
    autocmd BufRead,BufNewFile *.rb         setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.yml        setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.yaml       setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile Gemfile*     setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.erb        setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.html       setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.rake       setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.coffee     setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.css        setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.scss       setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile Rakefile     setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.js         setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.jsx        setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.ts         setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.tsx        setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.cpp,*.hpp  setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END

" Auto code styler.
augroup autoCodeStyler
    autocmd!
    autocmd BufEnter * set formatoptions=l " Disable auto comment out insert.
    autocmd BufEnter * setlocal noautoindent " Disable auto indent always.
augroup END

" Searh
set hlsearch                        " Hightlight search result
set incsearch                       " Incremental search
set nowrapscan                      " Search from Top of File after End
set ignorecase                      " Ignore CASE/case
set smartcase                       " Case sensitive if seach word includes large case

" Cursor
set ruler                           " Cursor ruler
set number                          " Line number
set scrolloff=4                     " Start scroll before cursor reaches to screen end
set cursorline                      " Cursor line highlight
"set cursorcolumn                    " Cursor column highlight
set whichwrap=h,l,<,>,[,]           " Move cursor from current head to upper line tail
set virtualedit=block               " Move cursor to anywhere even if there is no charactor
set showmatch                       " Show matched bracket for a while.
set noautoindent                    " Cursor is always on line-head after return.
set nosmartindent                   " Cursor is always on line-head after return.
set updatetime=300                  " event triggered in [ms] after cursor stopped

" Cursor jump to matched bracket by '%' key.
source $VIMRUNTIME/macros/matchit.vim

" View-based cursor move when line is soft-wrapped.
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" Shortcut Key
" Home/End
inoremap    <C-h>       <Esc>0i
inoremap    <C-l>       <Esc>$i
noremap     <C-h>       <Esc>0
noremap     <C-l>       <Esc>$
" PageUp/Down
noremap     <C-k>       <Esc><C-b>
noremap     <C-j>       <Esc><C-f>
" Cursor jump
noremap     <S-k>       10k
noremap     <S-j>       10j
" UnDo/ReDo
inoremap    <C-z>       <Esc>ui
inoremap    <C-y>       <Esc><C-r>i
" Remove Search Highlight
noremap     <Esc><Esc>  :noh<CR>
" De-indent
inoremap    <S-Tab>     <Esc><S-v><S-<>i
noremap     <S-Tab>     <S-v><S-<>
" Autocmd
augroup WinEnterLeave
    autocmd!
    autocmd WinEnter * setlocal cursorline
"    autocmd WinEnter * setlocal cursorcolumn
    autocmd WinLeave * setlocal nocursorline
"    autocmd WinLeave * setlocal nocursorcolumn
    augroup END

" Syntax
syntax enable                       " Syntax color

" Invisible Charactors
set list                            " Show invisible charactors
set listchars=tab:>\ ,trail:#       " Invisible charactors visible pattern

" Auto Refresh Buffer
set autoread                        " Auto refresh current buffer

" Auto Generated Files
set nobackup                        " Back up file
set nowritebackup
set noswapfile                      " Swap file

" Copy and Paste
set clipboard=unnamed,unnamedplus   " Use clipboard in common among other apps

" IME
set iminsert=0                      " IME On/Off in insert mode
set imsearch=0                      " IME On/Off in seach mode

" Explorer netrw
let g:netrw_liststyle=3             " Tree style
let g:netrw_altv=1                  " Open file at right side by 'v'
let g:netrw_alto=1                  " Open file at bottom side by 'o'
let g:netrw_browse_split=3          " Always open file on new tab
let g:netrw_banner=0                " Do not show banner
let g:netrw_keepdir=1               " Block change directory
let g:netrw_mousemaps=0             " Disable mouse event

" WORKAROUND : netrw tree view may be corrupted by focus granted event.
"              so, disable focus grant/loss vent.
set t_fe=
set t_fd=

" Tab page
set showtabline=2                   " Always show tab line
" Move to left tab
map H gT
" Move to right tab
map L gt

" Highlight for TabLine.
if &background == 'dark'
    highlight TabLine       cterm=NONE  ctermbg=8       ctermfg=black
    highlight TabLineSel    cterm=NONE  ctermbg=NONE    ctermfg=white
    highlight TabLineFill   cterm=NONE  ctermbg=8       ctermfg=black
else " background == light
    highlight TabLine       cterm=NONE  ctermbg=7       ctermfg=white
    highlight TabLineSel    cterm=NONE  ctermbg=NONE    ctermfg=black
    highlight TabLineFill   cterm=NONE  ctermbg=7       ctermfg=white
endif

" Each tab label
function! EachTabLabel(n)
    " Buffer name, type
    let l:buflist = tabpagebuflist(a:n)
    let l:buf = l:buflist[0]
    let l:buf_filetype = getbufvar(l:buf, '&filetype')
    let winnr = tabpagewinnr(a:n)  " active window number
    let bufname = bufname(buflist[winnr - 1])  " active buf name

    " Check netrw
    "TODO: Consider to refer to path (dir or file)
    let length = strlen(bufname)
    if 16 <= length
        let substr = bufname[0 : 15]
        if 'NetrwTreeListing' == substr
            " This is explorer tab.
            return '/'
        endif
    endif

    " check fern
    if l:buf_filetype ==# 'fern'
        return '/'
    endif

    " Show file name only.
    let l:filename = fnamemodify(bufname, ':t') " Get filename only
    return ' ' . l:filename . ' '
endfunction

" Total tab line
function! TotalTabLine()
    let s = ''

    for i in range(tabpagenr('$')) " Total tab page count
        " background highlight
        if (i + 1) == tabpagenr() " Current tab
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        " Each tab label.
        let s .= EachTabLabel(i + 1)
    endfor

    " Blank area.
    let s .= '%#TabLineFill#'

    return s
endfunction
set tabline=%!TotalTabLine()

" Command
set showcmd                         " Show inputting command
set wildmenu                        " Store command history
set history=2000                    " Command history max
set cmdheight=1                     " Cmd line height

" Beep sound
set visualbell t_vb=
set noerrorbells
set belloff=all

" Mouse
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

" Status line
set laststatus=2                    " Always status line ON
set showmode                        " Show current mode

" Insert/Normal mode change callback.
if has('syntax')
    augroup InsertHook
        " Remove all command related to InsertHook.
        autocmd!
        " Register callbacks.
        autocmd InsertEnter * call s:CustomStatusLine('enter')
        autocmd InsertLeave * call s:CustomStatusLine('leave')
    augroup END
endif

" Customize status line.
function! s:CustomStatusLine(mode)
    if a:mode ==# 'enter'
        silent set statusline=[INSERT]\ FILE=%F%m%=%{AleStatusLine()}\ \ LINE=%l/%L\ \ COL=%c
        highlight StatusLine cterm=NONE ctermbg=red ctermfg=white
    elseif a:mode ==# 'leave'
        silent set statusline=FILE=%F%m%=%{AleStatusLine()}\ \ LINE=%l/%L\ \ COL=%c
        if &background == 'dark'
            highlight StatusLine    cterm=NONE ctermbg=7 ctermfg=black
            highlight StatusLineNC  cterm=NONE ctermbg=8 ctermfg=black
        else
            highlight StatusLine    cterm=NONE ctermbg=8 ctermfg=white
            highlight StatusLineNC  cterm=NONE ctermbg=7 ctermfg=white
        endif
    endif
endfunction

" Change window
nnoremap <Tab>k <C-w>k
nnoremap <Tab>j <C-w>j
nnoremap <Tab>h <C-w>h
nnoremap <Tab>l <C-w>l
" Split window
set splitbelow
set splitright
nnoremap <Tab>s <C-w>s
nnoremap <Tab>v <C-w>v
nnoremap ss :split<CR>
nnoremap sv :vsplit<CR>
if &background == 'dark'
    highlight VertSplit ctermbg=gray ctermfg=black
else
    highlight VertSplit ctermbg=gray ctermfg=white
endif
" Resize window
nnoremap <Tab><up>      :resize -2<CR>
nnoremap <Tab><down>    :resize +2<CR>
nnoremap <Tab><left>    :vertical resize -2<CR>
nnoremap <Tab><right>   :vertical resize +2<CR>
nnoremap <Tab>=         <C-w>=
nnoremap <Tab>m         :wincmd _ \| wincmd \|<CR>
augroup OnConsoleResized
    autocmd!
    autocmd VimResized * wincmd =
augroup END

" To take effec lighlight after ESC immediately.
if has('unix') && !has('gui_running')
    set notimeout
    set ttimeout
    set timeoutlen=30
endif

" Remove tail spaces before save.
augroup RemoveTailSpace
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//ge
augroup END

" Plug-INs.
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
" Install plug-in manager.
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl'
    \       ' -fLo ' . data_dir . '/autoload/plug.vim'
    \       ' --create-dirs'
    \       ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
" Install plug-ins if not installed.
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
\|          PlugInstall --sync
\|      endif

call plug#begin()
"
" <<<<<< Plug-INs from HERE
"
" -----------------------------------------------------------

" Visualize tail white spaces.
Plug 'bronson/vim-trailing-whitespace'

" -----------------------------------------------------------

" Indent line.
Plug 'Yggdroot/indentLine'

let g:indentLine_color_term = 8
let g:indentLine_char = '¦'
let g:indentLine_enabled = 0  " default disabled

noremap     <C-i>   :IndentLinesToggle<CR>
nnoremap    <Tab>   <nop>

" -----------------------------------------------------------

" Coffee Script.
Plug 'kchmck/vim-coffee-script'

augroup SetupCoffeeScriptPlugin
    autocmd!
    autocmd BufRead,BufNewFile,BufReadPre *.coffee  set filetype=coffee
    autocmd FileType coffee                         setlocal tabstop=2 shiftwidth=2
augroup END

" -----------------------------------------------------------

" TypeScript.
Plug 'leafgarland/typescript-vim'

" -----------------------------------------------------------

" Search hit num pop up.
Plug 'obcat/vim-hitspop'

set hlsearch
let g:hitspop_line = 'wintop'
let g:hitspop_column = 'winright'

highlight link hitspopNormal StatusLine
highlight link hitspopErrorMsg StatusLine

" -----------------------------------------------------------

" Highlight current word and same word.
Plug 'dominikduda/vim_current_word'

let g:vim_current_word#enabled = 1
let g:vim_current_word#highlight_twins = 1  " highlight same word under cursor
let g:vim_current_word#highlight_current_word = 1  " highlight word under cursor
let g:vim_current_Word#highlight_only_in_focused_window = 1
let g:vim_current_word#highlight_delay = 500  " delayed [ms]

if &background == 'dark'
    highlight CurrentWord ctermfg=NONE ctermbg=237 cterm=NONE
    highlight CurrentWordTwins ctermfg=NONE ctermbg=237 cterm=NONE
else
    highlight CurrentWord ctermfg=NONE ctermbg=250 cterm=NONE
    highlight CurrentWordTwins ctermfg=NONE ctermbg=250 cterm=NONE
endif

augroup SetupCurrentWord
    autocmd!
    autocmd BufAdd *.txt,*.md :let b:vim_current_word_disabled_in_this_buffer = 1  " disabled file type
    autocmd BufAdd CMakeLists.txt :let b:vim_current_word_disabled_in_this_buffer = 0  " enabled exception
augroup END

" -----------------------------------------------------------

" Show scroll bar.
Plug 'obcat/vim-sclow'

let g:sclow_hide_full_length = 1  " Do not show scroll bar when all lines in screen.
let g:sclow_auto_hide = 1000  " Hide scroll bar in timeout [ms]

highlight link SclowSbar CurrentWord

" -----------------------------------------------------------

" Highlight matched brackets.
Plug 'luochen1990/rainbow'

let g:rainbow_active = 0  " disabled in default
let g:rainbow_conf = {
\   'ctermfgs': [21, 39, 51, 46, 226, 208, 196],
\   'cterms': ['bold'],
\   'separately': {
\       '*': {},
\       'text': 0,
\       'markdown': 0,
\   },
\}

nnoremap b :RainbowToggle<CR>

" -----------------------------------------------------------

" Syntax check. ( :ALEInfo for debug )
Plug 'dense-analysis/ale'

let g:ale_enabled = 1
let g:ale_linters_explicit = 1  " if linter is N/A, disable ALE

function! s:ale_setup()
    if !exists(':ALE*')
        return
    endif

    let l:linters = ale#linter#Get(&filetype)
    if empty(l:linters)
        " No linters, disable.
        let b:ale_enabled = 0
    else
        let b:ale_enabled = 1
        setlocal signcolumn=yes  " always show left edge sign area
    endif
endfunction

autocmd FileType,BufEnter * call s:ale_setup()

" apt install clangd
let g:ale_linters = {
\   'c': ['clangd'],
\   'cpp': ['clangd'],
\}

let g:ale_root = {
\   '*': ['.git'],
\}

let g:ale_c_build_dir = 'build'  " override for each env

function! GenCompileCommandsJson()
    " override for each env
endfunction

let g:ale_lint_on_text_changed = 'never'  " block lint during editing
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1
let g:ale_sign_error = 'E:'  " left edge sign
let g:ale_sign_warning = 'W:'  " left edeg sign
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %severity%/%code%: %s'  " echo msg of cursor line

function! AleStatusLine() abort
    if !exists(':ALE*')
        return
    endif

    call s:ale_setup()

    if b:ale_enabled != 1 || g:ale_enabled != 1
      return 'ALE=N/A'
    endif
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_warnings = l:counts.warning + l:counts.style_warning + l:counts.info
    let l:total = l:all_errors + l:all_warnings
    return l:total == 0 ? 'ALE=OK' : printf('ALE=E:%d/W:%d', l:all_errors, l:all_warnings)
endfunction

nnoremap <silent> m :ALENext<CR>
nnoremap <silent> <S-m> :ALEPrevious<CR>

let g:ale_set_highlights = 1

highlight ALEWarningSign    ctermbg=11  ctermfg=0   " yellow
highlight ALEWarning        ctermbg=3   ctermfg=0   " yellow
highlight ALEErrorSign      ctermbg=9   ctermfg=15  " red
highlight ALEError          ctermbg=1   ctermfg=15  " red

" -----------------------------------------------------------

" Fern filer to replace netrw.
Plug 'lambdalisue/vim-fern'

let g:fern#default_hidden = 1  " show hidden file
let g:fern#hide_cursor = 1  " hide cursor on fern buffer
let g:fern#disable_default_mappings = 1

nnoremap e :Fern . -opener=tabedit -reveal=%<CR>

function! FernMoveCursorToParentNode() abort
    let l:cur_indent = indent('.')
    while search('^\s*|-\s', 'b')  " backward search open dir '|-'
      let l:idt = indent('.')
      if l:idt < l:cur_indent || l:idt ==# 0
        " Hit parent dir or NOP on top level dir
        break
      endif
    endwhile
endfunction

let g:fern_expanded_dirs = []
let g:fern_retry_wait_ms = 30

function! s:FernSaveExpandedState() abort
    let g:fern_expanded_dirs = []
    let l:helper = fern#helper#new()
    let l:nodes = helper.fern.visible_nodes
    for node in l:nodes
        if node.status ==# g:fern#STATUS_EXPANDED
            call add(g:fern_expanded_dirs, node._path)
        endif
    endfor
endfunction

function! s:FernLoadExpandedState() abort
    if empty(g:fern_expanded_dirs)
        return
    endif

    let l:helper = fern#helper#new()
    let l:nodes = l:helper.fern.visible_nodes

    let l:cur_expanded_dirs = []

    for node in l:nodes
        " check node is expand target or not.
        let l:is_expand_target = 0
        for path in g:fern_expanded_dirs
            if node._path ==# path
                if node.status ==# g:fern#STATUS_EXPANDED
                    call add(l:cur_expanded_dirs, path)
                else
                    let l:is_expand_target = 1
                endif
                break
            endif
        endfor

        " expand node
        if l:is_expand_target ==# 1
            let l:key = copy(node.__key)  " lambda capture reference for list, dict.
            call l:helper.async.expand_node(l:key)

            " call 1 async func for each 1 FernLoadExpandedState()
            break
        endif
    endfor

    " check all expand target dir is expanded or not.
    let l:is_all_expanded = 1
    for path in g:fern_expanded_dirs
        let l:is_hit = 0
        for cur in l:cur_expanded_dirs
            if path ==# cur
                let l:is_hit = 1
                break
            endif
        endfor
        if l:is_hit ==# 0
            let l:is_all_expanded = 0
            break
        endif
    endfor

    if l:is_all_expanded
        let g:fern_expanded_dirs = []

        " reload all, for fail-safe.
        call timer_start(
        \       g:fern_retry_wait_ms,
        \       { -> feedkeys("\<Plug>(fern-action-reload:all)", 'n') })

        " move cursor to top.
        call cursor(1, 1)
    else
        " At least 1 path is not expanded yet, retry.
        call timer_start(
        \       g:fern_retry_wait_ms,
        \       { -> s:FernLoadExpandedState() })
    endif
endfunction

function! FernEnterKey() abort
    let l:helper = fern#helper#new()
    let l:cursor_node = helper.sync.get_cursor_node()
    let l:root_node = helper.sync.get_root_node()

    if l:cursor_node._path ==# l:root_node._path
        " on root node.

        call s:FernSaveExpandedState()

        execute 'Fern ' . fnamemodify(l:root_node._path, ':h')
        \       . ' -opener=tabedit'
    else
        " on non-root dir/file node.

        " for file, closed dir, opened dir
        execute 'normal ' . fern#smart#leaf(
        \       "\<Plug>(fern-action-open:tabedit)",
        \       "\<Plug>(fern-action-expand:stay)",
        \       "\<Plug>(fern-action-collapse)")
    endif
endfunction

function! s:initialize_custom_fern() abort
    setlocal nonumber
    setlocal signcolumn=yes
    setlocal foldcolumn=0

    nnoremap <buffer><nowait> h :call FernMoveCursorToParentNode()<CR>

    " for file, closed dir, opened dir
    nnoremap <buffer><expr> l fern#smart#leaf(
    \       "",
    \       "\<Plug>(fern-action-expand:stay)",
    \       "")

    nnoremap <buffer> <CR> :call FernEnterKey()<CR>

    " open fern on current tab.
    nnoremap <buffer><nowait> o <plug>(fern-action-open:edit)

    nnoremap <buffer><nowait> <F5> <Plug>(fern-action-reload)
endfunction

augroup FernCustomOnOpened
    autocmd!
    autocmd FileType fern call s:initialize_custom_fern()
    autocmd FileType fern call s:FernLoadExpandedState()
augroup END

" -----------------------------------------------------------

" Fern replace default netrw.
Plug 'lambdalisue/vim-fern-hijack'

" -----------------------------------------------------------

" Cheat sheet.
Plug 'liuchengxu/vim-which-key'

nnoremap <Esc>h :WhichKey ''<CR>

highlight link WhichKey StatusLineNC
highlight link WhichKeySeparator StatusLineNC
highlight link WhichKeyGroup StatusLineNC
highlight link WhichKeyDesc StatusLineNC
highlight link WhichKeyFloating StatusLineNC

" -----------------------------------------------------------






" -----------------------------------------------------------
"
" >>>>>> Plug-INs to HERE
"
call plug#end()

" VIM CP Scouter.
command! Scouter call Scouter()
function! Scouter()
    let vimrc_file = expand('~/.vimrc')
    let total = 0
    let valid = 0
    let comment = 0
    let empty = 0
    for line in readfile(vimrc_file)
        let total += 1
        if line =~# '^\s*"'
            let comment += 1
        elseif line =~# '^\s*$'
            let empty += 1
        else
            let valid += 1
        endif
    endfor

    echon printf('.vimrc | Valid+Comment+Empty/Total LINES = %d+%d+%d/%d',
    \       valid, comment, empty, total)
endfunction

" Open .vimrc and reload .vimrc immediately.
nnoremap <F2>   :<C-u>tabedit $MYVIMRC<CR>
nnoremap <F5>   :<C-u>source $MYVIMRC<CR>
" Escape for PuTTY, it considering F1-F4 as other key sequence.
nnoremap <F6>   :<C-u>tabedit $MYVIMRC<CR>

" Auto reload .vimrc
augroup AutoSourceVimrc
    autocmd!
    autocmd BufWritePost .vimrc,.vimrc_* source $MYVIMRC
augroup END

" Open netrw from command line.
command! Dir :Texplore






" End of .vimrc
" Load override properties.
" Place ~/.vimrc_override file for local environment.
if filereadable(expand($HOME.'/.vimrc_override'))
    source $HOME/.vimrc_override
endif



" Initialize
noh " Remove highlight after reload .vimrc
call s:ale_setup()
call s:CustomStatusLine('leave')

