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
set showcmd

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
    Plug 'itchyny/lightline.vim'

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
    Plug 'easymotion/vim-easymotion'
    Plug '~/.fzf'

    " Visual
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'connorholyday/vim-snazzy'

    " Syntax
    Plug 'vim-scripts/indentpython.vim'
    "Plug 'scrooloose/syntastic'
    Plug 'nvie/vim-flake8'
    Plug 'rust-lang/rust.vim'
    Plug 'isobit/vim-caddyfile'
    autocmd BufNewFile,BufRead *.Caddyfile set syntax=caddyfile

    " Auto completion
    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

call plug#end() | catch /^Vim\%((\a\+)\)\=:E117/ | endtry

" vim-fugitive
nnoremap <leader>g :Git

" vim-indent-guides
nmap <leader>i <Plug>IndentGuidesToggle
let g:indent_guides_auto_colors=0
let g:indent_guides_start_level=2
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_default_mapping=0

" vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" mundo.vim
let g:mundo_right = 1
nnoremap <leader>m :MundoToggle<CR>

" Python Syntax
let python_highlight_all=1
syntax on

" theme
colorscheme snazzy
let g:SnazzyTransparent = 1
"let g:lightline = { 'colorscheme': 'snazzy', }

" editorconfig
let g:EditorConfig_core_mode = 'external_command'

"
" coc
"
set hidden
set nowritebackup
set shortmess+=c
set signcolumn=yes

let g:coc_start_at_startup = 0

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <c-cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'snazzy',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }


" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
