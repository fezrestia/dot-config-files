".vimrc

" Encoding
    set encoding=utf-8

" Disable Key Mapping
    nnoremap    ZZ          <Nop>
    nnoremap    ZQ          <Nop>
    nnoremap    J           <Nop>
    nnoremap    K           <Nop>

" Tab
set tabstop=4
set expandtab
set shiftwidth=4

" Searh
    set hlsearch                        " Hightlight search result
    set incsearch                       " Incremental search
    set nowrapscan                      " Search from Top of File after End
    set ignorecase                      " Ignore CASE/case
    set smartcase                       " Case sensitive if seach word includes large case

" Cursor
    set ruler                           " Cursor ruler
    set number                          " Line number
    set scrolloff=8                     " Start scroll before cursor reaches to screen end
    set cursorline                      " Cursor line highlight
"    set cursorcolumn                    " Cursor column highlight
    set whichwrap=h,l,<,>,[,]           " Move cursor from current head to upper line tail
    set virtualedit=block               " Move cursor to anywhere even if there is no charactor
"   Shortcut Key
"       Home/End
            inoremap    <C-h>       <Esc>0i
            inoremap    <C-l>       <Esc>$i
            noremap     <C-h>       <Esc>0
            noremap     <C-l>       <Esc>$
"       PageUp/Down
            noremap     <C-k>       <Esc><C-b>
            noremap     <C-j>       <Esc><C-f>
"       UnDo/ReDo
            inoremap    <C-z>       <Esc>ui
            inoremap    <C-y>       <Esc><C-r>i
"       Remove Search Highlight
            noremap     <Esc><Esc>  :noh<CR>
"       De-indent
            inoremap    <S-Tab>     <Esc><S-v><S-<>i
            noremap     <S-Tab>     <S-v><S-<>
"   Autocmd
        autocmd WinEnter * setlocal cursorline
"        autocmd WinEnter * setlocal cursorcolumn
        autocmd WinLeave * setlocal nocursorline
"        autocmd WinLeave * setlocal nocursorcolumn

" Syntax
    syntax enable                       " Syntax color
    set showmatch                       " Show match bracket

" Invisible Charactors
    set list                            " Show invisible charactors
    set listchars=tab:>\ ,trail:#       " Invisible charactors visible pattern

" Auto Refresh Buffer
    set autoread                        " Auto refresh current buffer

" Auto Generated Files
    set nobackup                        " Back up file
    set noswapfile                      " Swap file

" Copy and Paste
    set clipboard=unnamed               " Use clipboard in common among other apps

" IME
    set iminsert=0                      " IME On/Off in insert mode
    set imsearch=0                      " IME On/Off in seach mode

" Explorer netrw
    let g:netrw_liststyle=3             " Tree style
    let g:netrw_altv=1                  " Open file at right side by 'v'
    let g:netrw_alto=1                  " Open file at bottom side by 'o'

" Tab
    set showtabline=2                   " Always show tab line
    " Move to left tab
        map H gT
    " Move to right tab
        map L gt

" Command
    set showcmd                         " Show inputting command

