".vimrc

" Tab
set tabstop=4
set expandtab
set shiftwidth=4

" Shortcut Key
"   Home/End
        inoremap    <C-h>       <Esc>^i
        inoremap    <C-l>       <Esc>$i
        noremap     <C-h>       <Esc>^
        noremap     <C-l>       <Esc>$
"   PageUp/Down
        noremap     <C-k>       <Esc><C-b>
        noremap     <C-j>       <Esc><C-f>
"   UnDo/ReDo
        inoremap    <C-z>       <Esc>ui
        inoremap    <C-y>       <Esc><C-r>i
"   Remove Search Highlight
        noremap     <Esc><Esc>  :noh<CR>

" Searh
    set hlsearch                        " Hightlight search result
    set incsearch                       " Incremental search
    set nowrapscan                      " Search from Top of File after End
    set ignorecase                      " Ignore CASE/case

" Cursor
    set ruler                           " Cursor ruler
    set number                          " Line number
    set scrolloff=8                     " Start scroll before cursor reaches to screen end
    set cursorline                      " Cursor line highlight
"    set cursorcolumn                    " Cursor column highlight
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

