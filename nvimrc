let mapleader=","
let mapllocaleader=","
call plug#begin()
Plug 'hynek/vim-python-pep8-indent'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'cschlueter/vim-wombat'
Plug 'benekastah/neomake'
Plug 'tomtom/tcomment_vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-markdown'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'junegunn/vim-easy-align'
Plug 'lervag/vimtex'
Plug 'tpope/vim-surround'
Plug 'fs111/pydoc.vim'
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/indentLine'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'
Plug 'carlitux/deoplete-ternjs'
Plug 'Shougo/neopairs.vim'
Plug 'Raimondi/delimitMate'
Plug 'ervandew/supertab'
Plug 'wincent/loupe'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'JuliaLang/julia-vim'
call plug#end()

let g:deoplete#enable_at_startup = 1
let g:vimtex_view_method='zathura'
let g:vimtex_latexmk_build_dir='build'
let g:SuperTabDefaultCompletionType = "<c-n>"

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

nmap Q @q
" complète avec la plus longue chaine commune et montre une liste de ceux qui reste
set wildmode=list:longest

set textwidth=79
set ff=unix
set spelllang=en
set spellfile=~/.spell.utf-8.add
set nospell

if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup pandoc_syntax
      au! BufNewFile,BufFilePRe,BufRead *.md set filetype=markdown.pandoc
  augroup END
  augroup reload_vimrc " {
      autocmd!
      autocmd BufWritePost $MYVIMRC source $MYVIMRC
      autocmd BufWritePost ~/.nvimrc source ~/.nvimrc
  augroup END " }
  augroup Mine
          autocmd BufEnter *.nv setlocal wrap spell nolinebreak
          au BufNewFile *.py 0r ~/.vim/templates/python
          au BufNewFile *.html 0r ~/.vim/templates/html
          au BufNewFile *.tex 0r ~/.vim/templates/xetex
  augroup END
endif

let g:limelight_conceal_ctermfg = 'DarkGray'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:UltiSnipsExpandTrigger="<c-z>"
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
autocmd! User GoyoLeave colo gruvbox
" for ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

map <Up> gk
map <Down> gj
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

tnoremap <Leader>e <C-\><C-n>
set hidden
" let g:racer_cmd = "/usr/bin/racer"
" let $RUST_SRC_PATH="/home/orphee/pkg/devel/rustc-nightly/src/"

" http://dougblack.io/words/a-good-vimrc.html
set lazyredraw
set cursorline
set foldlevelstart=5   " open most folds by default
" highlight last inserted text
nnoremap gV `[v`]
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
set background=dark
let base16colorspace=256
colo gruvbox

" http://vim.wikia.com/wiki/View_text_file_in_two_columns
noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" Use deoplete.
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0  " This do disable full signature type on autocomplete
" autocmd FileType javascript setlocal omnifunc=tern#Complete
