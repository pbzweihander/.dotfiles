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
" Remove highlight
nnoremap <silent> ,<Space> :noh<CR>
" Easy save
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

"
" Commands
"

" save with sudo
cmap w!! %!sudo tee > /dev/null %

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
    Plug 'vim-utils/vim-interruptless'
    Plug 'junegunn/gv.vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'airblade/vim-gitgutter'
    Plug '~/.fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'vim-scripts/BufOnly.vim'
    Plug 'google/vim-searchindex'
    Plug 'kshenoy/vim-signature'

    " The Pope
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-vinegar'
    Plug 'tpope/vim-commentary'

    " Visual
    Plug 'Yggdroot/indentLine'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'connorholyday/vim-snazzy'

    " Languages
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'cespare/vim-toml'
    Plug 'elzr/vim-json'
    Plug 'hashivim/vim-terraform'
    Plug 'nirum-lang/nirum.vim'
    Plug 'neovimhaskell/haskell-vim'

    " Language server and Auto completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
    \         [ 'cocstatus', 'currentfunction' ],
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
    \     'cocstatus': 'coc#status',
    \     'currentfunction': 'CocCurrentFunction'
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

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" coc.nvim
set updatetime=100
set completeopt=noinsert,menuone,noselect
set shortmess+=c

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <silent> <F1> :<C-u>CocList<cr>
imap <silent> <F1> <Esc>:<C-u>CocList<cr>
nmap <silent> <F2> <Plug>(coc-rename)
imap <silent> <F2> <ESC><Plug>(coc-rename)
nmap <silent> <leader>f <Plug>(coc-format)
xmap <silent> <leader>f <Plug>(coc-format-selected)
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>ac <Plug>(coc-codeaction)

autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap <silent> <leader><leader><Space>  :<C-u>CocList<cr>
nnoremap <silent> <leader><leader>d  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader><leader>c  :<C-u>CocList commands<cr>
nnoremap <silent> <leader><leader>o  :<C-u>CocList outline<cr>
nnoremap <silent> <leader><leader>p  :<C-u>CocListResume<CR>

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

" alt
function! AltCommand(path, vim_command)
  let l:alternate = system("alt " . a:path)
  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction

nnoremap <leader>. :call AltCommand(expand('%'), ':e')<cr>

" vim-commentary
nnoremap <C-/> gcc
inoremap <C-/> <ESC>gcca

" vim-vinegar
nnoremap = <C-^>
