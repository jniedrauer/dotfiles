set nocompatible              " required
filetype off                  " required

let mapleader = ","

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'bitc/vim-bad-whitespace'
Plugin 'scrooloose/syntastic'
Plugin 'integralist/vim-mypy'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'PProvost/vim-ps1'
Plugin 'fatih/vim-go'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'SirVer/ultisnips'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Defaults
set tabstop=4
set shiftwidth=4
set expandtab
set encoding=utf-8
set backspace=2 " MacOS is bad
set ruler
set clipboard=unnamedplus
let python_highlight_all=1
colorscheme peachpuff
syntax on

" IDE
" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
" Show docstring
let g:SimpylFold_docstring_preview=1
" Enable shellcheck following
let g:syntastic_sh_shellcheck_args="-x"

" Use pylintrc for syntastic
let g:syntastic_python_pylint_args = '--rcfile=./pylintrc'

" Clear duplicate autocmds
augroup vimrc_autocmd
  au!
  " Remember last file position
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  " Highlight whitespace at end of lines
  au BufNewFile,BufRead match BadWhitespace /\s\+$/
  au BufNewFile,BufRead Jenkinsfile setf groovy
augroup END
