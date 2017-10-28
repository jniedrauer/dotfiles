set tabstop=4
set shiftwidth=4
set expandtab
syntax on

" Remember last file position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
