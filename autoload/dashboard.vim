function! dashboard#open() abort
    enew
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal nobuflisted
    setlocal noswapfile
    setlocal nonumber norelativenumber
    setlocal signcolumn=no
    setlocal foldcolumn=0
    setlocal cursorline
    setlocal modifiable

    let l:lines = [
    \ '     ██╗ ██████╗ ███████╗████████╗██╗   ██╗██╗███╗   ███╗',
    \ '     ██║██╔═══██╗██╔════╝╚══██╔══╝██║   ██║██║████╗ ████║',
    \ '     ██║██║   ██║███████╗   ██║   ██║   ██║██║██╔████╔██║',
    \ '██   ██║██║   ██║╚════██║   ██║   ██║   ██║██║██║╚██╔╝██║',
    \ '╚█████╔╝╚██████╔╝███████║   ██║   ╚██████╔╝██║██║ ╚═╝ ██║',
    \ ' ╚════╝  ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝ ╚═╝╚═╝     ╚═╝',
    \ '',
    \ '      [n]  New File       ',
    \ '      [r]  Recent Files   ',
    \ '      [q]  Quit           ',
    \ '',
    \ '      ' . strftime('%c'),
    \ ''
    \ ]

    let l:pad_top   = max([0, float2nr((winheight(0) - len(l:lines)) / 2)])
    let l:win_width = winwidth(0)
    let l:centered  = map(copy(l:lines), {_, val -> repeat(' ', float2nr((l:win_width - strwidth(val)) / 2)) . val})

    call append(0, repeat([''], l:pad_top) + l:centered)
    call cursor(1, 1)
    setlocal nomodifiable

    nnoremap <silent> <buffer> n :enew<CR>
    nnoremap <silent> <buffer> r :call dashboard#recent()<CR>
    nnoremap <silent> <buffer> q :qa<CR>
endfunction

function! dashboard#recent() abort
    setlocal modifiable

    let s:recent_files = []
    let l:recent_lines = ['']
    let i = 1
    for file in v:oldfiles
        if filereadable(file)
            call add(s:recent_files, file)
            call add(l:recent_lines, printf('   [%d]  %s', i % 10, fnamemodify(file, ':~')))
            let i += 1
        endif
    if i > 10 | break | endif
    endfor

    call append('$', l:recent_lines)

    for idx in range(len(s:recent_files))
        let key = (idx + 1) % 10
        execute printf("nnoremap <buffer> %d :call dashboard#openrecent(%d)<CR>", key, idx)
    endfor

    setlocal nomodifiable
endfunction

function! dashboard#openrecent(index) abort
    if a:index < len(s:recent_files)
        execute 'edit ' . fnameescape(s:recent_files[a:index])
    endif
endfunction

