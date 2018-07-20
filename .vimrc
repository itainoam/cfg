
if empty(glob('~/.vim/autoload/plug.vim'))
  wombatwombatsilent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
Plug 'flazz/vim-colorschemes'
Plug 'metakirby5/codi.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'w0rp/ale'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

let mapleader = ' ' " map leader to space
nnoremap <leader>h :helpgrep<space>
" Quickly quit editting without save
nnoremap <leader>q :q<CR>
nnoremap <leader><leader>q :q!<CR>
nnoremap <leader>w :w<cr>
nnoremap <leader><leader>w :wq<cr>
nnoremap <leader>o :CtrlPMRU<cr>

colorscheme seoul256
let g:seoul256_background = 233
syntax enable
set number

set wildmenu
set wildmode=longest:full,full

set timeoutlen=1000 ttimeoutlen=0 "elimentates delay when getting in and out of cmd
let g:ale_lint_on_text_changed = 'never'

set incsearch              " Highlight Search
set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.
