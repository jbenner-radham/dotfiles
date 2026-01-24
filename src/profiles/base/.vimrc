" Use spaces instead of tabs.
set expandtab

" Enable filetype plugins.
filetype plugin on
filetype indent on

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" The amount of whitespace used for one level of indentation.
set shiftwidth=2

" The amount of spaces represented when the tab key is pressed.
set softtabstop=-1 " Use the width of `shiftwidth`.

" Show matching brackets when text indicator is over them.
set showmatch

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number
