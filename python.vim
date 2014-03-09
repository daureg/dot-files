setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=78
setlocal smarttab
setlocal nosmartindent
setlocal expandtab

" Active l'auto-complétion pour python
set omnifunc=pythoncomplete#Complete

" sur pression de la touche F3, highlight les caractères qui dépassent la 79ème colonne
map <silent> <F3> "<Esc>:match ErrorMsg '\%>79v.\+'<CR>"

" met en surbrillance les espaces et les tabs en trop
" pas réellement pour le python mais j'aime bien
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

map <silent> <F4> "<Esc>:w!<cr>:!python2 %<cr>"
set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
set makeprg=python2
