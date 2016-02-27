" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

" filetype off
" set rtp+=~/.vim/bundle/Vundle.vim/
" call vundle#begin()
" Plugin 'gmarik/Vundle.vim'
" Plugin 'fs111/pydoc.vim'
" Plugin 'kien/ctrlp.vim'
" Plugin 'Lokaltog/vim-easymotion'
" Plugin 'rking/ag.vim'
" Plugin 'scrooloose/syntastic'
" Plugin 'tomtom/tcomment_vim'
" Plugin 'tpope/vim-surround'
" Plugin 'tpope/vim-speeddating.git'
" " Plugin 'Valloric/YouCompleteMe'
" " Plugin 'wakatime/vim-wakatime'
" Plugin 'tpope/vim-fugitive'
" Plugin 'terryma/vim-expand-region'
" Plugin 'matze/vim-move'
" Plugin 'AndrewRadev/splitjoin.vim'
" Plugin 'sheerun/vim-polyglot'
" Plugin 'ConvertBase.vim'
" Plugin 'vim-scripts/DoxygenToolkit.vim'
" Plugin 'marijnh/tern_for_vim'
" Plugin 'othree/javascript-libraries-syntax.vim'
" Plugin 'pangloss/vim-javascript'
" Plugin 'idbrii/AsyncCommand'
" Plugin 'gorkunov/smartpairs.vim'
" Plugin 'techlivezheng/vim-plugin-minibufexpl'
" Plugin 'docunext/closetag.vim'
" Plugin 'kristijanhusak/vim-multiple-cursors'
" Plugin 'rust-lang/rust.vim'
" Plugin 'phildawes/racer'
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
" Plugin 'junegunn/vim-easy-align'
" Plugin 'vim-pandoc/vim-pandoc'
" Plugin 'vim-pandoc/vim-pandoc-syntax'
" Plugin 'NLKNguyen/papercolor-theme'
" " Track the engine.
" Plugin 'SirVer/ultisnips'
" " Snippets are separated from the engine. Add this if you want them:
" Plugin 'honza/vim-snippets'
" Plugin 'tpope/vim-vinegar'
" Plugin 'junegunn/goyo.vim'
" Plugin 'junegunn/limelight.vim'

"Clojure

" Plugin 'guns/vim-clojure-static'
" Plugin 'tpope/vim-salve'
" Plugin 'tpope/vim-fireplace'
" call vundle#end()
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<c-z>"
" let g:UltiSnipsJumpForwardTrigger="<c-z>"
" let g:UltiSnipsJumpBackwardTrigger="<s-z>"

" Suffixes that get lower priority when doing tab completion for filenames.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Make shift-insert work like in Xterm
if has('gui_running')
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

set background=dark
set t_Co=256
set textwidth=78
set enc=utf-8
set ff=unix
set nospell
set spelllang=en
set spellfile=~/.spell.utf-8.add
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file
set history=5000	" keep 5000 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  augroup Mine
	  autocmd Filetype latex setlocal conceallevel=0
	  autocmd Filetype tex setlocal conceallevel=0
	  autocmd BufEnter *.nv setlocal wrap spell nolinebreak
	  " Template
	  au BufNewFile *.py 0r ~/.vim/templates/python
	  au BufNewFile *.html 0r ~/.vim/templates/html
	  au BufNewFile *.tex 0r ~/.vim/templates/xetex
	  autocmd BufRead *.cpp set cindent
	  autocmd BufRead *.h set cindent
  augroup END

else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

nmap ,t :ToggleWord<CR>

" Utilise Ctrl-Tab pour changer d'onglets
map <C-Tab> gt

" F2 donne la date
map <F2> a<C-R>=strftime("%c")<CR><Esc>

" complète avec la plus longue chaine commune et montre une liste de ceux qui
" reste
set wildmode=list:longest

" Tout ce qui est sauvegardé sous viminfo
" set viminfo='1000,f1,<500

" Tout ce qui est sauvegardé avec les sessions
" set sessionoptions='1000,f1,<500 +tab

" Flash visuel en cas d'erreur (30 ms)
"set visualbell t_vb="<Esc>|10f"

" To move in screen line for very long line
map <Up> gk
map <Down> gj
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

" execute pathogen#infect()
"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

" if exists("*AddCycleGroup")
" 	call AddCycleGroup(['on', 'off'])
" 	call AddCycleGroup('python', ['True', 'False'])
" endif
" let g:indentLine_color_term = 239
" let g:indentLine_char = '¦'
set listchars=eol:↵,tab:>-,trail:×,nbsp:␣
" https://groups.google.com/forum/?fromgroups#!topic/vim_dev/yJ1etO80AKc
" set regexpengine=1

" Retourne à la parenthèse ouvrante en fermant.
set showmatch
set matchtime=4

" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" undofile tells Vim to create <FILENAME>.un~ files whenever you edit a file.
" These files contain undo information so you can undo previous actions even
" after you close and reopen a file.
" set undofile
" set colorcolumn=85
inoremap jj <ESC>
set laststatus=0
" change the mapleader from \ to space bar
let mapleader=","
set timeoutlen=300
let g:EasyMotion_leader_key = '<Leader>'
let g:netrw_browsex_viewer= "firefox"
let g:syntastic_python_checkers=['flake8', 'pylint']
let g:syntastic_python_flake8_args="--max-complexity 13"
let g:syntastic_python_pylint_args="-d C0325"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMRU'


" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
" let g:ctrlp_use_caching = 0
" vmap <Enter> <Plug>(expand_region_expand)
" vmap <C-Enter> <Plug>(expand_region_shrink)
let g:table_mode_tableize_map = '<Leader>mt'
let g:table_mode_echo_cell_map = '!'
imap <C-Z> <Plug>snipMateNextOrTrigger
smap <C-Z> <Plug>snipMateNextOrTrigger
let b:javascript_fold = 0
nmap Q @q

" https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>
" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>
" Show all open buffers and their status
nmap <leader>bl :ls<CR>
let g:miniBufExplorerAutoStart = 0

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

set hidden
let g:racer_cmd = "/usr/bin/racer"
let $RUST_SRC_PATH="/home/orphee/pkg/devel/rustc-nightly/src/"
"from http://blog.sanctum.geek.nz/vim-annoyances/
nnoremap K <nop>

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
