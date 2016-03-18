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

" Property
"   Searh
        set hlsearch
        set incsearch

