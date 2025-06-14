function! dashboard#buffer#Create() abort
    enew
    execute 'file ' . g:dashboard_name
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal nobuflisted
    setlocal noswapfile
    setlocal nonumber norelativenumber
    setlocal signcolumn=no
    setlocal foldcolumn=0
    setlocal cursorline
    setlocal modifiable
    setlocal filetype=dashboard
endfunction
