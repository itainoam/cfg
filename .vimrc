if empty(glob('~/.vim/autoload/plug.vim'))
  wombatwombatsilent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
Plug 'flazz/vim-colorschemes'
Plug 'metakirby5/codi.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'w0rp/ale'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
call plug#end()
"LSP config augroup filetype_js autocmd!  autocmd BufReadPost *.js setlocal filetype=javascript augroup END let g:LanguageClient_autoStart = 1 let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ }

"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
 command! -bang -nargs=* Ag
   \ call fzf#vim#ag(<q-args>,
   \                 <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'},'up:60%')
   \                         : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'},'right:50%:hidden', '?'),
   \                 <bang>0)
 
autocmd! User FzfStatusLine call <SID>fzf_statusline()
" for setting the correct root folder for mui
let g:LanguageClient_rootMarkers = {
          \ 'javascript': ['*/js'],
          \ }     
" replace go-to-definition to use lsp
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>

let mapleader = ' ' " map leader to space
nnoremap <leader>r :History<cr>
nnoremap <leader>o :Files<cr>
nnoremap <leader>f :Ag!<cr>

" update is like save but only runs when file has change so doesn't change
" date
nnoremap <leader><leader>s :update<cr>

"scrolling 
nmap <C-j> 3j3<C-e>
nmap <C-k> 3k3<C-y>

" Auto reload changed files  
set autoread


" Buffer management
nnoremap <leader>[  :bprevious<CR>
nnoremap <leader>] :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>


let g:highlightedyank_highlight_duration = 200

colorscheme seoul256
let g:seoul256_background = 233
syntax enable
set number

set wildmenu
set wildmode=longest:full,full
" Customize fzf colors to match your color scheme

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" use ag
let $FZF_DEFAULT_COMMAND = 'ag -g ""'



" ale config
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_linters = {
\   'javascript': ['eslint'],
\}
set signcolumn="yes"
let g:ale_sign_column_always = 1
" always keep gutter open
autocmd BufRead,BufNewFile * setlocal signcolumn=yes

set timeoutlen=1000 ttimeoutlen=0 "elimentates delay when getting in and out of cmd
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

" Maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

" shows insert cursor in iTerm2
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Maintain undo history between sessions
set clipboard=unnamed

