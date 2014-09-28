" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'fs111/pydoc.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-speeddating.git'
Bundle 'Valloric/YouCompleteMe'
Bundle 'wakatime/vim-wakatime'
Bundle 'tpope/vim-fugitive'
Bundle 'terryma/vim-expand-region'
" Bundle 'dhruvasagar/vim-table-mode'
Bundle 'machakann/vim-patternjump'
Bundle 'matze/vim-move'
Bundle 'tpope/vim-vinegar'
" Bundle 'amix/vim-zenroom'
Bundle 'chrisbra/DistractFree'
Bundle 'AndrewRadev/splitjoin.vim'
Bundle 'sheerun/vim-polyglot'
Bundle 'ConvertBase.vim'
Bundle 'KabbAmine/vCoolor.vim'
Bundle 'vim-scripts/DoxygenToolkit.vim'
Bundle 'marijnh/tern_for_vim'
Bundle 'othree/javascript-libraries-syntax.vim'
Bundle "pangloss/vim-javascript"
Bundle 'dart-lang/dart-vim-plugin'

Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"

" Track the engine.
Bundle 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Bundle 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-z>"
let g:UltiSnipsJumpForwardTrigger="<c-z>"
let g:UltiSnipsJumpBackwardTrigger="<s-z>"

" Suffixes that get lower priority when doing tab completion for filenames.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Make shift-insert work like in Xterm
if has('gui_running')
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

set background=dark
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
