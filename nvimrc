if &shell =~# 'fish$'
    set shell=sh
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'khaveesh/vim-fish-syntax'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'ianchanning/vim-selenized'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'fs111/pydoc.vim'
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/indentLine'
Plug 'farmergreg/vim-lastplace'
Plug 'wakatime/vim-wakatime'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} " use tree sitter instead
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'chrisbra/Colorizer'
Plug 'wsdjeg/vim-fetch'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'Shougo/deoplete.nvim'
" Plug 'zchee/deoplete-jedi'
" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
" Plug 'codota/tabnine-vim'
Plug 'cespare/vim-toml'
Plug 'ervandew/supertab'
Plug 'editorconfig/editorconfig-vim'
" Plug 'phaazon/hop.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'hashivim/vim-terraform'
Plug 'rhysd/committia.vim'
call plug#end()

set mouse=a
colo selenized
nmap Q @q
" complète avec la plus longue chaine commune et montre une liste de ceux qui reste
set wildmode=list:longest
let mapleader = "\<Space>"
set textwidth=100
set ff=unix
set spelllang=en
set spellfile=~/.spell.utf-8.add
set nospell
map <Up> gk
map <Down> gj
" If you prefer the Omni-Completion tip window to close when a selection is made, these lines close
" it on movement in insert mode or when leaving insert mode
autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
vmap <Leader>y "+y
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

if has("autocmd")
  au BufRead,BufNewFile *.painless set filetype=groovy
  au FileType gitcommit let b:EditorConfig_disable=1
  augroup reload_vimrc " {
      autocmd!
      autocmd BufWritePost $MYVIMRC source $MYVIMRC
  augroup END " }
  augroup pandoc_syntax
      au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
  augroup END
endif

" for ctrlp: https://gist.github.com/darrylhebbes/4cc1b0995c265e8e08509b48954642c6
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMRU'
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
endif

let g:limelight_conceal_ctermfg = 'DarkGray'
let g:indentLine_color_term = 240
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
autocmd! User GoyoLeave colo selenized
let g:pandoc#syntax#conceal#use=0
let g:startify_custom_header = ''

" http://dougblack.io/words/a-good-vimrc.html
set lazyredraw
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" highlight last inserted text
nnoremap gV `[v`]

let g:github_enterprise_urls = ['https://github.bus.zalan.do']

" https://github.com/neoclide/coc.nvim#example-vim-configuration
set hidden
" set signcolumn=number
set updatetime=300


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

set guifont="Rec Mono Duotone:h18"
set laststatus=1
let g:committia_edit_window_width=73

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" https://docs.sourcery.ai/Guides/Getting-Started/Vim/
nnoremap <silent> <leader>cl :CocDiagnostics<cr>
nnoremap <silent> <leader>ch :call CocAction('doHover')<cr>
nnoremap <silent> <leader>cf <plug>(coc-codeaction-cursor)
nnoremap <silent> <leader>ca <plug>(coc-fix-current)
nmap <silent> [c <plug>(coc-diagnostic-prev)
nmap <silent> ]c <plug>(coc-diagnostic-next)
