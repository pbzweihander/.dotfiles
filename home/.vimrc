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
set noshowmode
set nofoldenable
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
set number
set cursorline
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
" Easy Indentation
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" Easy Splitting
nnoremap <silent> <C-_> :split<CR>
nnoremap <silent> <C-\> :vertical split<CR>
" Easy Navigation
nnoremap <silent> <C-h> <C-w><C-h>
nnoremap <silent> <C-j> <C-w><C-j>
nnoremap <silent> <C-k> <C-w><C-k>
nnoremap <silent> <C-l> <C-w><C-l>
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
    Plug 'simnalamburt/vim-mundo'
    Plug 'tpope/vim-git'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-obsession'
    Plug 'godlygeek/tabular'
    Plug 'vim-utils/vim-interruptless'
    Plug 'junegunn/gv.vim'
    Plug 'justinmk/vim-dirvish'
    Plug 'editorconfig/editorconfig-vim'

    " Visual
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'junegunn/seoul256.vim'

    " Syntax
    Plug 'vim-scripts/indentpython.vim'
    Plug 'scrooloose/syntastic'
    Plug 'nvie/vim-flake8'
    Plug 'rust-lang/rust.vim'
    Plug 'isobit/vim-caddyfile'
    autocmd BufNewFile,BufRead *.Caddyfile set syntax=caddyfile

    " Auto completion
    "Plug 'maralla/completor.vim'

call plug#end() | catch /^Vim\%((\a\+)\)\=:E117/ | endtry

" vim-airline
let g:airline_powerline_fonts = 1

" vim-fugitive
nnoremap <leader>g :Git

" vim-indent-guides
nmap <leader>i <Plug>IndentGuidesToggle
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_default_mapping = 0

" vim-better-whitespace
let g:strip_whitespace_on_save = 1

" mundo.vim
let g:mundo_right = 1
nnoremap <leader>m :MundoToggle<CR>

" Python Syntax
let python_highlight_all=1
syntax on

" rustfmt
let g:rustfmt_autosave = 1


"
" Beautiful vim
"

set background=dark
let g:seoul256_background = 233
colo seoul256
let s:backcolor = 234

if !exists('s:rgb_map')
    let s:rgb_map = {
                \ 'NONE': 'NONE',
                \ 'white': '#FFFFFF', 'black': '#191919',
                \ 16: '#000000', 160: '#D70000',
                \ 226: '#FFFF00', 233: '#171717',
                \ 234: '#252525'}
endif

function! s:rs(item)
    execute printf("highlight %s cterm=NONE gui=NONE", a:item)
endfunction
function! s:fg(item, color)
    execute printf("highlight %s ctermfg=%s guifg=%s", a:item, a:color, get(s:rgb_map, a:color))
endfunction
function! s:bg(item, color)
    execute printf("highlight %s ctermbg=%s guibg=%s", a:item, a:color, get(s:rgb_map, a:color))
endfunction

call s:fg('MatchParen', 226)
call s:bg('MatchParen', 16)

call s:bg('ExtraWhitespace', 160)
if &softtabstop < 4 || !&expandtab
    call s:bg('IndentGuidesOdd', 'NONE')
else
    let g:indent_guides_guide_size = 1
    call s:bg('IndentGuidesOdd', s:backcolor)
endif
call s:bg('IndentGuidesEven', s:backcolor)
