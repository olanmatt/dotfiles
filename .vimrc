""
"" Basics
""
" be iMproved, required
set nocompatible

" use tpope/vim-sensible
packadd! vim-sensible
packadd! YouCompleteMe

""
"" Packages
""
" YouCompleteMe
let g:ycm_confirm_extra_conf = 0

""
"" General
""
" enable mouse mode
set mouse=a

" show line numbers
set number

" show existing tab with 3 spaces width
set tabstop=3

" when indenting with '>', use 3 spaces width
set shiftwidth=3

" On pressing tab, insert 3 spaces
set expandtab

" 100 character limit line
set colorcolumn=100

" change completion behaviour
set wildmode=longest,list,full

" enable syntax highlighting
syntax on

" enable search highlighting
set hlsearch

" set fold on syntax
set foldmethod=syntax
set foldlevel=99

""
"" Misc
""
" update color scheme
if filereadable(expand("~/.vimrc_background"))
   let base16colorspace=256
   source ~/.vimrc_background
endif

" rename tmux windows to use file names
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window '" . expand("%:t") . "'")
autocmd VimLeave * call system("tmux setw automatic-rename")
