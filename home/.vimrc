"
" General Configs
"

scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set shell=/bin/bash
set pastetoggle=<F8>
set scrolloff=3
set startofline
set splitbelow splitright
set nobackup
set noswapfile
if !has('nvim')
    set nocompatible
endif
set noshowmode
set nofoldenable
set nowrap
set showcmd
set signcolumn=yes

" Indentation
set cindent
set autoindent
set smartindent

" Tab
set softtabstop=4
set shiftwidth=4
set expandtab

" Searching
set ignorecase
set smartcase
set hlsearch
set nowrapscan
set incsearch

" Line Number Column
set number
set cursorline
" Pair Matching
set matchpairs+=<:>
set showmatch

"
" Key Mappings
"

" Easy Home/End
inoremap <C-a> <ESC>I
inoremap <C-e> <ESC>A
nnoremap <C-a> ^
nnoremap <C-e> $
vnoremap <C-a> ^
vnoremap <C-e> $
" Easy Delete Key
vnoremap <silent> <backspace> "_d
" Easy Indentation
vnoremap <silent> <Tab> >gv
vnoremap <silent> <S-Tab> <gv
" Easy Splitting
nnoremap <silent> <C-_> :split<CR>
nnoremap <silent> <C-\> :vertical split<CR>
" Easy Navigation
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
" Tab Navigations
nnoremap <silent> <a-t> :tabnew<CR>
nnoremap <silent> <a-T> :-tabnew<CR>
nnoremap <silent> <a-1> 1gt
nnoremap <silent> <a-2> 2gt
nnoremap <silent> <a-3> 3gt
nnoremap <silent> <a-4> 4gt
nnoremap <silent> <a-5> 5gt
nnoremap <silent> <a-6> 6gt
nnoremap <silent> <a-7> 7gt
nnoremap <silent> <a-8> 8gt
nnoremap <silent> <a-9> 9gt
" Line Moving
nnoremap <silent> <S-Up> :m-2<CR>
nnoremap <silent> <S-Down> :m+<CR>
inoremap <silent> <S-Up> <Esc>:m-2<CR>
inoremap <silent> <S-Down> <Esc>:m+<CR>

"
" Plugins
"

try | call plug#begin(exists('s:plug') ? s:plug : '~/.vim/plugged')
    Plug 'itchyny/lightline.vim'

    Plug 'simnalamburt/vim-mundo'
    Plug 'tpope/vim-git'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-sensible'
    Plug 'vim-utils/vim-interruptless'
    Plug 'junegunn/gv.vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'airblade/vim-gitgutter'
    Plug '~/.fzf'
    Plug 'junegunn/fzf.vim'

    " Visual
    Plug 'Yggdroot/indentLine'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'connorholyday/vim-snazzy'

    " Languages
    Plug 'leafgarland/typescript-vim'

    " Language server and Auto completion
    Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif

call plug#end() | catch /^Vim\%((\a\+)\)\=:E117/ | endtry

"
" Plugin Configs
"

" Persistent history
if has('persistent_undo')
  let vimdir='$HOME/.vim'
  let &runtimepath.=','.vimdir
  let vimundodir=expand(vimdir.'/undodir')
  call system('mkdir -p '.vimundodir)

  let &undodir=vimundodir
  set undofile
endif

" indentLine
nnoremap <silent> <leader>i :IndentLinesToggle<CR>
let g:indentLine_char='▏'

" vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" mundo.vim
let g:mundo_right = 1
nnoremap <silent> <leader>m :MundoToggle<CR>

" theme
colorscheme snazzy
let g:SnazzyTransparent = 1

" lightline
let g:lightline = {
    \ 'colorscheme': 'snazzy',
    \ 'active': {
    \   'left': [
    \     [ 'mode', 'paste' ],
    \     [ 'gitbranch', 'readonly', 'filename', 'modified', 'lcstatus' ],
    \   ],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'lcstatus': 'LanguageClient#serverStatusMessage',
    \ },
    \ }

" editorconfig
let g:EditorConfig_core_mode = 'external_command'

" language-server
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'python': ['~/.pyenv/shims/pyls'],
    \ 'javascript': ['~/.yarn/bin/typescript-language-server', '--stdio'],
    \ 'typescript': ['~/.yarn/bin/typescript-language-server', '--stdio'],
    \ }

nnoremap <silent> <F1> :call LanguageClient_contextMenu()<CR>
inoremap <silent> <F1> <ESC>:call LanguageClient_contextMenu()<CR>
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F12> :call LanguageClient#textDocument_references()<CR>
inoremap <silent> <F12> <ESC>:call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
inoremap <silent> <F2> <ESC>:call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <leader>f :call LanguageClient#textDocument_formatting()<CR>

" deoplete
let g:deoplete#enable_at_startup = 1
let g:python3_host_prog = '/usr/bin/python'
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <C-Space> deoplete#mappings#manual_complete()

" fzf
let g:fzf_action = {
    \ 'ctrl-q': 'wall | bdelete',
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit',
    \ }
nnoremap <silent> <leader><Tab> :Files<CR>
nnoremap <silent> <leader><leader><Tab> :Files!<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader><leader>b: Buffers!<CR>
nnoremap <leader>r :Rg<space>
nnoremap <leader><leader>r :Rg!<space>

" gv
nnoremap <silent> <leader>g :GV<CR>
nnoremap <silent> <leader><leader>g :GV!<CR>

" gitgutter
nnoremap <silent> <leader>G :GitGutterToggle<CR>
