call plug#begin('~/.vim/plugged')
" Plug 'mattn/emmet-vim'
" Plug 'vim-scripts/ucompleteme'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jreybert/vimagit'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
Plug 'tribela/vim-transparent'
Plug 'junegunn/goyo.vim'
" Plug 'goballooning/vim-live-latex-preview'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'dgraham/vim-eslint'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" Plug 'manzeloth/live-server'
Plug 'lervag/vimtex'
call plug#end()


" space to tab
map T :%s/ \s/\t/g<Return>

" nnoremap x "_x
nmap Q F"xf"x
map q ysiw"hxp

" space to tab
map T :%s/ \s/\t/g<Return>

if has('nvim')
	autocmd VimEnter * call timer_start(8, { tid -> execute(':set termguicolors')})
endif
let g:Hexokinase_highlighters = ['backgroundfull']

" automatically edits swap warning
autocmd SwapExists * let v:swapchoice = "e" | echomsg "swap exists"

" copy paste
set pastetoggle=<F1>
vnoremap <C-c> "+y
vnoremap <C-d> "+y:delete<Return>
map <C-p> <F1> :set paste "+P :set nopaste <F1>
map <C-p> <F1> :set paste "+p :set nopaste <F1>
vnoremap <C-c> "*y :let @+=@*<CR>
noremap <C-y> ggVG "*y :let @+=@*<CR>

nnoremap <C-q> :Goyo<Return>
nnoremap ff :Files<Return>
" nnoremap q :Sex<Return>

map <C-b> :%s/\[[^][]*\]//g<Return> :%s/[ \t]*$//g<Return> :%s/\/\ /\//g<Return> :%s/\ /-/g<Return>
" map <C-b> :%s/\[[^][]*\]//g<Return> :%s/\/\ /\//g<Return> :%s/\ \ \ //g<Return> :%s/\ \ //g<Return> :%s/\ /-/g<Return>

" paragraph hop
noremap J }
noremap K {

" hop to top or bottom
noremap H b
noremap L w

" search
" noremap F /

" set spell spelllang=ID_ID
" setlocal spell spelllang=id_id,en_us
" noremap <C-i> :set spell spelllang=ID_ID<Return>
" noremap <C-e> :set spell spelllang=EN_US<Return>

noremap <C-n> :set nospell!<Return>
autocmd VimEnter * call timer_start(8, { tid -> execute(':set spelllang=id_id')})

" disable autoquote
let b:coc_pairs_disabled = ['"',"'","(",")"]

" defaults and dash syntax highlighting
set linebreak
set nocompatible
colorscheme murphy
" syntax on
autocmd BufRead * if getline(1) == '#!/usr/bin/dash' | set filetype=sh | endif

" vim insert cursor mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" vimtex
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'
map cc :VimtexCompile<Return>:VimtexCompile<Return>
map C :VimtexCompile<Return>

" save as sudo
cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" recompile suckless programs
autocmd BufWritePost config.h,config.def.h,blocks.h !sudo make install

" transparent vim with st
hi Normal ctermbg=none
hi NonText ctermbg=none
hi LineNr ctermbg=none
set number relativenumber
set mouse=a
" filetype plugin indent on
set modifiable

" tab spacing
" set autoindent expandtab tabstop=2 shiftwidth=2

" disable autocomment
autocmd BufNewFile,BufRead * setlocal formatoptions-=ro

" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
  au!
  autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" May need for vim (not neovim) since coc.nvim calculate byte offset by count
" utf-8 byte sequence.
set encoding=utf-8
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
