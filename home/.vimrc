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
set colorcolumn=79,99

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
" Easy Resize
nnoremap <silent> <C-A-h> :vertical resize -2<CR>
nnoremap <silent> <C-A-j> :resize -2<CR>
nnoremap <silent> <C-A-k> :resize +2<CR>
nnoremap <silent> <C-A-l> :vertical resize +2<CR>
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
" Buffer Navigations
nnoremap <silent> <Tab><Tab> :b #<CR>
" Easy delete
inoremap <A-BS> <C-w>

"
" Filetype specific
"

autocmd FileType json setlocal sw=2 sts=2 et
autocmd FileType yaml setlocal sw=2 sts=2 et

"
" Plugins
"

try | call plug#begin(exists('s:plug') ? s:plug : '~/.vim/plugged')
    Plug 'itchyny/lightline.vim'

    Plug 'simnalamburt/vim-mundo'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-obsession'
    Plug 'vim-utils/vim-interruptless'
    Plug 'junegunn/gv.vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'airblade/vim-gitgutter'
    Plug '~/.fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'vim-scripts/BufOnly.vim'

    " Visual
    Plug 'Yggdroot/indentLine'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'connorholyday/vim-snazzy'

    " Languages
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'cespare/vim-toml'
    Plug 'elzr/vim-json'
    Plug 'hashivim/vim-terraform'

    " Language server and Auto completion
    Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'
    if has('nvim-0.4')
        Plug 'ncm2/float-preview.nvim'
    endif

call plug#end() | catch /^Vim\%((\a\+)\)\=:E117/ | endtry

"
" Plugin Configs
"

let g:python3_host_prog = '/usr/bin/python'

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
autocmd FileType markdown let g:indentLine_enabled=0
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
let g:lightline = {}
let g:lightline.colorscheme = 'snazzy'
let g:lightline.active = {
    \     'left': [
    \         [ 'mode', 'paste' ],
    \         [ 'filename', 'readonly' ],
    \         [ 'truncate_here' ],
    \     ],
    \     'right': [
    \         [ 'lineinfo' ],
    \         [ 'percent' ],
    \         [ 'gitbranch', 'fileformat', 'fileencoding', 'filetype' ],
    \     ],
    \ }
let g:lightline.component = {
    \     'truncate_here': '%<',
    \ }
let g:lightline.component_visible_condition = {
    \     'truncate_here': 0,
    \ }
let g:lightline.component_type = {
    \     'truncate_here': 'raw',
    \ }
let g:lightline.component_function = {
    \     'readonly': 'LightlineReadonly',
    \     'filename': 'LightlineFilename',
    \     'fileformat': 'LightlineFileformat',
    \     'fileencoding': 'LightlineFileencoding',
    \     'filetype': 'LightlineFiletype',
    \     'gitbranch': 'fugitive#head',
    \     'lcstatus': 'LanguageClient#serverStatusMessage',
    \ }

function! LightlineReadonly()
  return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

function! LightlineFileformat()
  return winwidth(0) > 90 ? &fileformat : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 100 ? &fileencoding : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 80 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

" language-server
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rls'],
    \ 'python': ['~/.pyenv/shims/pyls'],
    \ 'javascript': ['~/.yarn/bin/typescript-language-server', '--stdio'],
    \ 'typescript': ['~/.yarn/bin/typescript-language-server', '--stdio'],
    \ 'typescript.tsx': ['~/.yarn/bin/typescript-language-server', '--stdio'],
    \ }
let g:LanguageClient_useFloatingHover = 1

nnoremap <F1> :call LanguageClient_contextMenu()<CR>
inoremap <F1> <ESC>:call LanguageClient_contextMenu()<CR>
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F12> :call LanguageClient#textDocument_references()<CR>
inoremap <silent> <F12> <ESC>:call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
inoremap <silent> <F2> <ESC>:call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <leader>f :call LanguageClient#textDocument_formatting()<CR>
nnoremap <silent> <leader>* :call LanguageClient#textDocument_documentHighlight()<CR>
nnoremap <silent> <leader>e :call LanguageClient#explainErrorAtPoint()<CR>

" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()

set completeopt=noinsert,menuone,noselect
set shortmess+=c

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" fzf
let g:fzf_action = {
    \     'ctrl-t': 'tab split',
    \     'ctrl-x': 'split',
    \     'ctrl-v': 'vsplit',
    \ }
nnoremap <silent> <leader><Tab> :Files<CR>
nnoremap <silent> <leader><leader><Tab> :Files!<CR>
nnoremap <silent> <leader>q :Buffers<CR>
nnoremap <silent> <leader><leader>q :Buffers!<CR>
nnoremap <leader>r :Rg<space>
nnoremap <leader><leader>r :Rg!<space>

" gv
nnoremap <silent> <leader>g :GV<CR>
nnoremap <silent> <leader><leader>g :GV!<CR>

" gitgutter
nnoremap <silent> <leader>G :GitGutterToggle<CR>

" vim-obsession
nnoremap <silent> <leader>o :Obsess<CR>
nnoremap <silent> <leader>O :Obsess!<CR>

" float-preview
let g:float_preview#docked = 1

" BufOnly.vim
command! -nargs=? -complete=buffer -bang Bo
    \ :call BufOnly('<args>', '<bang>')

" vim-json
let g:vim_json_syntax_conceal = 0
