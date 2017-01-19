"
" General Configs
"

set t_ut=
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set shell=/bin/bash
set diffopt+=iwhite,vertical
set pastetoggle=<F8>
set scrolloff=3
set switchbuf+=usetab,split
set startofline
set splitbelow
set nobackup
if !has('nvim')
    set nocompatible
endif
set nofoldenable
set noshowmode
set noswapfile
set nowrap

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

" Line Number Column
"set number
"set cursorline
" 80th Column Color
"set textwidth=80
"set formatoptions-=t
"if v:version >= 703
"    set colorcolumn=+1,+2,+3
"endif
" Listchars
"set list
" Pair Matching
set matchpairs+=<:>
set showmatch
" Wildmenu
set wildmode=longest,full

"
" Key Mappings
"

let g:mapleader = ","

" Easy Command-Line Mode
nnoremap ; :
" Easy Home/End
inoremap <C-a> <ESC>I
inoremap <C-e> <ESC>A
nnoremap <C-a> ^
nnoremap <C-e> $
vnoremap <C-a> ^
vnoremap <C-e> $
" Easy Delete Key
vnoremap <backspace> "_d
" Easy Newline Insert
nnoremap <CR> o<ESC>
" Easy File Save
nnoremap <silent> <C-s> :update<CR>
inoremap <silent> <C-s> <ESC>:update<CR>
vnoremap <silent> <C-s> <ESC>:update<CR>
" Easy Indentation
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" Easy Splitting & Resizing
nnoremap <silent> <C-_> :split<CR>
nnoremap <silent> <C-\> :vertical split<CR>
nnoremap <silent> <C-h> :vertical resize -5<CR>
nnoremap <silent> <C-j> :resize -3<CR>
nnoremap <silent> <C-k> :resize +3<CR>
nnoremap <silent> <C-l> :vertical resize +5<CR>
" Tab Navigations
nnoremap <esc>t :tabnew<CR>
nnoremap <esc>T :-tabnew<CR>
nnoremap <esc>1 1gt
nnoremap <esc>2 2gt
nnoremap <esc>3 3gt
nnoremap <esc>4 4gt
nnoremap <esc>5 5gt
nnoremap <esc>6 6gt
nnoremap <esc>7 7gt
nnoremap <esc>8 8gt
nnoremap <esc>9 9gt
" Tab Navigations
nnoremap <a-t> :tabnew<CR>
nnoremap <a-T> :-tabnew<CR>
nnoremap <a-1> 1gt
nnoremap <a-2> 2gt
nnoremap <a-3> 3gt
nnoremap <a-4> 4gt
nnoremap <a-5> 5gt
nnoremap <a-6> 6gt
nnoremap <a-7> 7gt
nnoremap <a-8> 8gt
nnoremap <a-9> 9gt
" Line Moving
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

"
" Plugins
"

try | call plug#begin(exists('s:plug') ? s:plug : '~/.vim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-git'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-obsession'
    "if v:version >= 703
    "    Plug 'mhinz/vim-startify'
    "endif
    Plug 'godlygeek/tabular'
    Plug 'vim-utils/vim-interruptless'
    Plug 'junegunn/gv.vim'
    Plug 'justinmk/vim-dirvish'

    " Visual
    "Plug 'nathanaelkane/vim-indent-guides'
    Plug 'ntpeters/vim-better-whitespace'
    "Plug 'junegunn/seoul256.vim'

    " Syntax
    Plug 'elixir-lang/vim-elixir'

    " Blink
    "Plug 'rhysd/clever-f.vim'
    "Plug 'Lokaltog/vim-easymotion'

call plug#end() | catch /^Vim\%((\a\+)\)\=:E117/ | endtry

" vim-airline
let g:airline_powerline_fonts = 1

" vim-indent-guides
"nmap <leader>i <Plug>IndentGuidesToggle
"let g:indent_guides_auto_colors = 1
"let g:indent_guides_start_level = 1
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_exclude_filetypes = ['help', 'startify']
"let g:indent_guides_default_mapping = 0

" vim-better-whitespace
let g:strip_whitespace_on_save = 1

"
" Beautiful vim
"

colorscheme elflord
"colorscheme seoul256

