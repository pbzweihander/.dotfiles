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
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/asyncomplete-buffer.vim'
    Plug 'prabirshrestha/asyncomplete-file.vim'
    Plug 'tsufeki/asyncomplete-fuzzy-match', {
        \ 'do': 'cargo build --release',
        \ }
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

" vim-lsp
if executable('pyls')
    " Use flake8 with https://github.com/emanspeaks/pyls-flake8
    au User lsp_setup call lsp#register_server({
        \     'name': 'pyls',
        \     'cmd': ['pyls'],
        \     'whitelist': ['python'],
        \     'workspace_config': {
        \         'pyls': {
        \             'configurationSources': ["flake8"],
        \             'plugins': {
        \                 'mccabe': { 'enabled': v:false },
        \                 'pyflakes': { 'enabled': v:false },
        \                 'pycodestyle': { 'enabled': v:false },
        \             },
        \         },
        \     },
        \ })
endif

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \     'name': 'rls',
        \     'cmd': {server_info->['rls']},
        \     'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \     'whitelist': ['rust'],
        \ })
endif

if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \     'name': 'typescript-language-server',
        \     'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \     'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \     'whitelist': ['typescript', 'typescript.tsx'],
        \ })


    au User lsp_setup call lsp#register_server({
        \     'name': 'javascript support using typescript-language-server',
        \     'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \     'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
        \     'whitelist': ['javascript', 'javascript.jsx', 'javascriptreact'],
        \ })
endif

nnoremap <F1> :LspCodeAction<CR>
inoremap <F1> <ESC>:LspCodeAction<CR>
nnoremap <silent> K :LspHover<CR>
nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gD :LspPeekDefinition<CR>
nnoremap <silent> gf :LspDeclaration<CR>
nnoremap <silent> gF :LspPeekDeclaration<CR>
nnoremap <silent> gr :LspReferences<CR>
nnoremap <silent> <F2> :LspRename<CR>
inoremap <silent> <F2> <ESC>:LspRename<CR>
nnoremap <silent> <leader>f :LspDocumentFormat<CR>
vnoremap <silent> <leader>f :LspDocumentRangeFormat<CR>
nnoremap <silent> <leader>e :LspNextError<CR>

let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_highlight_references_enabled = 1

let g:lsp_signs_hint = {'text': '➤'}
let g:lsp_signs_information = {'text': 'ℹ'}
let g:lsp_signs_warning = {'text': '⚠'}
let g:lsp_signs_error = {'text': '✗'}

highlight LspHintHighlight cterm=underline ctermbg=235 gui=underline guibg=#192224 guisp=#192224
highlight LspInformationHighlight cterm=underline ctermbg=235 gui=underline guibg=#192224 guisp=#192224
highlight LspWarningHighlight cterm=underline ctermbg=235 gui=underline guibg=#192224 guisp=#192224
highlight LspErrorHighlight cterm=underline ctermbg=235 gui=underline guibg=#192224 guisp=#192224

" asyncomplete
let g:asyncomplete_auto_completeopt = 0
set completeopt=noinsert,menuone,noselect
set shortmess+=c

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"

imap <C-Space> <Plug>(asyncomplete_force_refresh)

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \     'name': 'buffer',
    \     'whitelist': ['*'],
    \     'completor': function('asyncomplete#sources#buffer#completor'),
    \     'config': {
    \         'max_buffer_size': 5000000,
    \     },
    \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \     'name': 'file',
    \     'whitelist': ['*'],
    \     'priority': 10,
    \     'completor': function('asyncomplete#sources#file#completor'),
    \ }))

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

let g:vista_default_executive = 'vim_lsp'
let g:vista_fzf_preview = ['right:50%']

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

"
" Filetype specific
"

autocmd BufNewFile,BufRead *.yaml.example set ft=yaml
autocmd FileType json setlocal sw=2 sts=2 et
autocmd FileType yaml setlocal sw=2 sts=2 et
autocmd Filetype sql setlocal sw=2 sts=2 et
autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:
autocmd FileType terraform nnoremap <silent> <leader>f :TerraformFmt<cr>
autocmd FileType rust setlocal matchpairs+=<:>
