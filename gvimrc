set background=dark
colorscheme kib_darktango
if has("gui_gtk2")
	set guifont=Inconsolata-g\ For\ Powerline\ 14
endif

let g:indentLine_color_gui = '#80776b'
" from http://gniourf-gniourf.blogspot.fr/2011/11/true-full-screen-for-gvim.html
set guioptions=aci
function! ToggleFullScreen()
   call system("wmctrl -i -r ".v:windowid." -b toggle,fullscreen")
   redraw
endfunction
nnoremap <M-f> :call ToggleFullScreen()<CR>
inoremap <M-f> <C-\><C-O>:call ToggleFullScreen()<CR>
