let s:recent_files = []

function! dashboard#Open() abort
    call dashboard#Initialize()
    call dashboard#Draw()
endfunction

function! dashboard#Initialize() abort
    enew
    execute 'file Jostvim'
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

function! dashboard#Keymaps() abort
    nnoremap <silent> <buffer> n :enew<CR>
    nnoremap <silent> <buffer> r :call dashboard#Recent()<CR>
    nnoremap <silent> <buffer> q :qa<CR>
endfunction

function! dashboard#Draw() abort
    setlocal modifiable
    let lnum = search('^\s*\[1\]\s', 'nw')
    if lnum > 0
        let s:recent_lines = getline(lnum, '$')
    else
        let s:recent_lines = []
    endif
    silent! %delete _

    let l:logo      = dashboard#Logo()
    let l:menu      = dashboard#Menu()
    let l:extras    = dashboard#Extras()
    let s:dashboard = l:logo + l:menu + l:extras

    call dashboard#Resize()
    call dashboard#Print()
    call dashboard#Keymaps()
    call cursor(1, 1)

    setlocal nomodifiable
endfunction

function! dashboard#Print() abort
    call append(0, repeat([''], s:pad_top) + s:centered)
    if !empty(s:recent_lines) | call append(line('$'), s:recent_lines) | endif
endfunction

function! dashboard#Resize() abort
    let s:pad_top   = max([0, float2nr((winheight(0) - len(s:dashboard)) / 2)])
    let s:width     = winwidth(0)
    let s:centered  = map(copy(s:dashboard), {_, val -> repeat(' ', float2nr((s:width - strwidth(val)) / 2)) . val})
endfunction

function! dashboard#Recent() abort
    setlocal modifiable
    let lnum = search('^\s*\[1\]\s', 'nw')
    if lnum > 0
        execute lnum . ',$delete _'
    endif
    let s:recent_files = []
    let l:recent_lines = []
    let i = 1
    for file in v:oldfiles
        if filereadable(file)
            call add(s:recent_files, file)
            call add(l:recent_lines, printf('   [%d]  %s', i % 10, fnamemodify(file, ':~')))
            let i += 1
        endif
        if i > 10 | break | endif
    endfor

    call append(line('$'), l:recent_lines)

    for idx in range(len(s:recent_files))
        let key = (idx + 1) % 10
        execute printf("nnoremap <buffer> %d :call dashboard#OpenRecent(%d)<CR>", key, idx)
    endfor

    setlocal nomodifiable
endfunction

function! dashboard#OpenRecent(index) abort
    if exists('s:recent_files') && a:index < len(s:recent_files)
        execute 'edit ' . fnameescape(s:recent_files[a:index])
    endif
endfunction

function! dashboard#Logo() abort
    return [
    \ '     ██╗ ██████╗ ███████╗████████╗██╗   ██╗██╗███╗   ███╗',
    \ '     ██║██╔═══██╗██╔════╝╚══██╔══╝██║   ██║██║████╗ ████║',
    \ '     ██║██║   ██║███████╗   ██║   ██║   ██║██║██╔████╔██║',
    \ '██   ██║██║   ██║╚════██║   ██║   ██║   ██║██║██║╚██╔╝██║',
    \ '╚█████╔╝╚██████╔╝███████║   ██║   ╚██████╔╝██║██║ ╚═╝ ██║',
    \ ' ╚════╝  ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝ ╚═╝╚═╝     ╚═╝',
    \ ''
    \ ] 
endfunction

function! dashboard#Menu() abort
    return [
    \ '      [n]  New File       ',
    \ '      [r]  Recent Files   ',
    \ '      [q]  Quit           ',
    \ ''
    \ ]
endfunction

function! dashboard#Extras() abort
    return [
    \ '      ' . strftime('%c'),
    \ ''
    \ ]
endfunction
