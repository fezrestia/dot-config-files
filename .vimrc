".vimrc

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
set tabstop=4
set expandtab
set shiftwidth=4

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

" Control indent width by file extension.
augroup fileTypeIndent
    autocmd!
    autocmd BufRead,BufNewFile *.rb         setlocal tabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.yml        setlocal tabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.yaml       setlocal tabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile Gemfile*     setlocal tabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.erb        setlocal tabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.html       setlocal tabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.rake       setlocal tabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.coffee     setlocal tabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.css        setlocal tabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.scss       setlocal tabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile Rakefile     setlocal tabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.js         setlocal tabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.jsx        setlocal tabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.ts         setlocal tabstop=2 shiftwidth=2
    autocmd BufRead,BufNewFile *.tsx        setlocal tabstop=2 shiftwidth=2
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
noh " Remove highlight after reload .vimrc

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

" Tab page
set showtabline=2                   " Always show tab line
" Move to left tab
map H gT
" Move to right tab
map L gt

" Highlight for TabLine.
if &background == 'dark'
    highlight TabLine       cterm=NONE  ctermbg=white   ctermfg=black
    highlight TabLineSel    cterm=NONE  ctermbg=NONE    ctermfg=white
    highlight TabLineFill   cterm=NONE  ctermbg=white   ctermfg=black
else " background == light
    highlight TabLine       cterm=NONE  ctermbg=black   ctermfg=white
    highlight TabLineSel    cterm=NONE  ctermbg=NONE    ctermfg=black
    highlight TabLineFill   cterm=NONE  ctermbg=black   ctermfg=white
endif

" Each tab label
function! EachTabLabel(n)
    " Buffer name
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let bufname = bufname(buflist[winnr - 1])

    " Check netrw
    "TODO: Consider to refer to path (dir or file)
    let length = strlen(bufname)
    if 16 < length
        let substr = bufname[0 : 15]
        if 'NetrwTreeListing' == substr
            " This is explorer tab.
            return '/'
        endif
    endif

    " Show file name only.
    let l:filename = fnamemodify(bufname, ':t') " Get filename only
    return '[' . a:n . ']' .  l:filename
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
        let s .= ' '
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
        silent set statusline=[INSERT]\ FILE=%F%m%=LINE=%l/%L\ \ COL=%c
        highlight StatusLine cterm=NONE ctermbg=red ctermfg=white
    elseif a:mode ==# 'leave'
        silent set statusline=FILE=%F%m%=LINE=%l/%L\ \ COL=%c
        if &background == 'dark'
            highlight StatusLine cterm=NONE ctermbg=white ctermfg=black
        else
            highlight StatusLine cterm=NONE ctermbg=black ctermfg=white
        endif
    endif
endfunction

" Initialize
call s:CustomStatusLine('leave')

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
if has('vim_starting') " Only on first load.
    set runtimepath+=~/.vim/bundle/neobundle.vim " Path setting.

    " If NeoBundle is not installed yet, git clone it.
    " TODO: Consider proxy environment.
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "Now on Installing NeoBundle..."
        call system("mkdir ~/.vim/bundle/neobundle.vim")
        call system("git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" <<<<<< Plug-INs from HERE

" Visualize tail white spaces.
NeoBundle 'bronson/vim-trailing-whitespace'

" Indent line.
NeoBundle 'Yggdroot/indentLine'
let g:indentLine_color_term = 8
let g:indentLine_char = '¦'
noremap     <C-i>   :IndentLinesToggle<CR>

" Coffee Script.
NeoBundle 'kchmck/vim-coffee-script'
augroup SetupCoffeeScriptPlugin
    autocmd!
    autocmd BufRead,BufNewFile,BufReadPre *.coffee  set filetype=coffee
    autocmd FileType coffee                         setlocal tabstop=2 shiftwidth=2
augroup END

" TypeScript.
NeoBundle 'leafgarland/typescript-vim'
augroup SetupTypeScriptPlugin
    autocmd!
    autocmd BufRead,BufNewFile *.ts set filetype=typescript
augroup END






" >>>>>> Plug-INs to HERE
call neobundle#end()
filetype plugin indent on
NeoBundleCheck " Check for uninstalled plug-ins.

" VIM CP Scouter.
command! Scouter call Scouter()
function! Scouter()
    let vimrc_file = expand('~/.vimrc')
    let line_count = 0
    for line in readfile(vimrc_file)
        let line_count += 1
    endfor

    echon ".vimrc lines count = "
    echon line_count
endfunction

" Open .vimrc and reload .vimrc immediately.
nnoremap <F2>   :<C-u>tabedit $MYVIMRC<CR>
nnoremap <F5>   :<C-u>source $MYVIMRC<CR>
" Escape for PuTTY, it considering F1-F4 as other key sequence.
nnoremap <F6>   :<C-u>tabedit $MYVIMRC<CR>

" Open netrw from command line.
command! Dir :Texplore






" End of .vimrc
" Load local properties.
" Place ~/.vimrc_local file on local environment.
if filereadable(expand($HOME.'/.vimrc_local'))
    source $HOME/.vimrc_local
endif

