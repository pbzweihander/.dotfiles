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
set colorcolumn=79,99,119

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
set showmatch

filetype plugin on
syntax on

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
" Visual to search
vnoremap // "vy/\V<C-R>=escape(@v,'/\')<CR><CR>

"
" Commands
"

" save with sudo
if has('nvim')
    cmap w!! w suda://%
else
    cmap w!! w !sudo tee %
endif

" Mistypings
command Q :q
command Qa :qa

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
    Plug 'psliwka/vim-smoothie'
    if has('nvim')
        Plug 'lambdalisue/suda.vim'
    endif
    Plug 'skywind3000/vim-quickui'
    Plug 'APZelos/blamer.nvim'
    Plug 'AndrewRadev/splitjoin.vim'
    Plug 'vimwiki/vimwiki'

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
    Plug 'neoclide/jsonc.vim'
    Plug 'hashivim/vim-terraform'
    Plug 'nirum-lang/nirum.vim'
    Plug 'neovimhaskell/haskell-vim'

    " Language server and Auto completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
    Plug 'fannheyward/coc-markdownlint', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
    Plug 'fannheyward/coc-sql', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-yank', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
    Plug 'liuchengxu/vista.vim'

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
    \         [ 'currentfunction' ],
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
    \     'currentfunction': 'NearestMethodOrFunction'
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

function! NearestMethodOrFunction()
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

" coc.nvim
set updatetime=100
set completeopt=preview,noinsert,menuone,noselect
set shortmess+=c

let g:coc_disable_startup_warning = 1

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

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

nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <silent> <C-x> <Plug>(coc-cursors-word)*
xmap <silent> <C-x> <Plug>(coc-cursors-range)
nmap <leader>x  <Plug>(coc-cursors-operator)

autocmd CursorHold * silent call CocActionAsync('highlight')

highlight link CocCursorRange NONE
highlight CocCursorRange guibg=#b16286 guifg=#ebdbb2

" coc-yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" fzf
let g:fzf_action = {
    \     'ctrl-t': 'tab split',
    \     'ctrl-x': 'split',
    \     'ctrl-v': 'vsplit',
    \ }
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(
    \     <q-args>,
    \     fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}),
    \     <bang>0)
command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \     'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
    \     1,
    \     fzf#vim#with_preview(),
    \     <bang>0)
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

" vista
nnoremap <leader>v :Vista!!<CR>
nnoremap <leader><leader>v :Vista finder<CR>

let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']

" autocmd User lsp_buffer_enabled call vista#RunForNearestMethodOrFunction()
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" blamer.nvim
let g:blamer_enabled = 1
let g:blamer_show_in_visual_modes = 0

" vimwiki
let wiki = {}
let wiki.path = '~/pbzweihander.github.io/wiki/'
let wiki.ext = '.md'

let internal_wiki = {}
let internal_wiki.path = '~/internal_wiki/'
let internal_wiki.syntax = 'markdown'
let internal_wiki.ext = '.md'
let internal_wiki.path_html = '~/internal_wiki/out/'
let internal_wiki.custom_wiki2html = 'vimwiki_markdown'

let g:vimwiki_list = [wiki, internal_wiki]
let g:vimwiki_conceallevel = 0
let g:vimwiki_global_ext = 0

"
" Filetype specific
"

autocmd BufNewFile,BufRead *.yaml.example set ft=yaml
autocmd FileType json setlocal sw=2 sts=2 et
autocmd FileType yaml setlocal sw=2 sts=2 et
autocmd FileType yaml setlocal indentkeys-=<:>
autocmd FileType yaml setlocal indentkeys-=:
autocmd Filetype sql setlocal sw=2 sts=2 et
autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:
autocmd FileType terraform nnoremap <silent> <leader>f :TerraformFmt<cr>
autocmd FileType rust setlocal matchpairs+=<:>
autocmd FileType markdown DisableStripWhitespaceOnSave
autocmd FileType vimwiki setlocal conceallevel=0
autocmd FileType scss setlocal sw=2 sts=2 et
autocmd FileType css setlocal sw=2 sts=2 et
