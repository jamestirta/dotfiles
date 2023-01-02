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
" Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" Plug 'manzeloth/live-server'
Plug 'lervag/vimtex'
" Plug 'gennaro-tedesco/nvim-jqx'
" Plug 'bfrg/vim-jqplay'
Plug 'bkad/CamelCaseMotion'
Plug 'vito-c/jq.vim'
" Plug 'dhruvasagar/vim-table-mode'
Plug 'mechatroner/rainbow_csv'
Plug 'godlygeek/tabular'
call plug#end()
" respect camelCase
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

" save
map <C-s> :w<Return>

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
nnoremap <C-y> ggVG

nnoremap <C-q> :Goyo<Return>
nnoremap ff :Files<Return>
" nnoremap q :Sex<Return>

map <C-b> :%s/\[[^][]*\]//g<Return> :%s/[ \t]*$//g<Return> :%s/\/\ /\//g<Return> :%s/\ /-/g<Return>
" map <C-b> :%s/\[[^][]*\]//g<Return> :%s/\/\ /\//g<Return> :%s/\ \ \ //g<Return> :%s/\ \ //g<Return> :%s/\ /-/g<Return>

" paragraph hop
" map <C-j> }
" map <C-k> {


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
filetype plugin indent on
set modifiable

" tab spacing
" set autoindent expandtab tabstop=2 shiftwidth=2

" disable autocomment
autocmd BufNewFile,BufRead * setlocal formatoptions-=ro


" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <c-l>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><c-h> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
" nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

map J }
map K {
