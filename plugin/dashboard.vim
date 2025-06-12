if exists('g:loaded_mydashboard') | finish | endif
let g:loaded_mydashboard = 1

autocmd VimEnter * if argc() == 0 && !exists('g:dashboard_loaded') |
      \ let g:dashboard_loaded = 1 |
      \ call dashboard#Open() |
      \ endif

