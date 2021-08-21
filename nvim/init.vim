call plug#begin('~/.config/nvim/plugged')

" Theme
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'embark-theme/vim', { 'as': 'embark' }

" GUI enhancement
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntactic language support
Plug 'godlygeek/tabular'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'
Plug 'pangloss/vim-javascript'
Plug 'tasn/vim-tsx'

Plug 'dense-analysis/ale'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" default leader + p
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

let g:prettier#config#print_width = 80
let g:prettier#config#tab_width = 2

call plug#end()

colorscheme embark
let g:lightline = {
      \ 'colorscheme': 'embark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
      \ }
      \ }
set termguicolors

" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

set rnu
set number
set mouse=a
set laststatus=2
set statusline+=%F

" copy (write) highlighted text to .vimbuffer
vmap <C-c> y:new ~/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.vimbuffer \| clip.exe <CR><CR>
" paste from buffer
map <C-v> :r ~/.vimbuffer<CR>

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'rust': ['rustfmt'],
\   'typescript': ['prettier'],
\}

let g:ale_linters = {
\   'javascript': ['tsserver'],
\   'typescript': ['tsserver'],
\}

let g:ale_fix_on_save = 1
let g:ale_set_ballons = 1
let g:ale_set_highlights = 1

let mapleader=" "
nnoremap <SPACE> <Nop>

noremap <leader>s :Rg<CR>
map <C-p> :Files<CR>
nnoremap <Leader><space> :noh<cr>
inoremap jk <esc>
inoremap kj <esc>

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gs :split<CR><Plug>(coc-definition)
nmap <silent> gv :vsplit<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
