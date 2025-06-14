let s:recent_files = []
let s:recent_lines = []

function! dashboard#menu#recentfiles#command() abort
    return { "keymap":"r", "label":"Recent Files", "command":":call dashboard#menu#recentfiles#display()<CR>"}
endfunction

function! dashboard#menu#recentfiles#get() abort
    let i = 1
    for file in v:oldfiles
        if filereadable(file)
            call add(s:recent_files, file)
            call add(s:recent_lines, printf('   [%d]  %s', i % 10, fnamemodify(file, ':~')))
            let i += 1
        endif
        if i > 10 | break | endif
    endfor
endfunction

function! dashboard#menu#recentfiles#print() abort
    call append(line('$'), s:recent_lines)
    for idx in range(len(s:recent_files))
        let key = (idx + 1) % 10
        execute printf("nnoremap <buffer> %d :call dashboard#menu#recentfiles#open(%d)<CR>", key, idx)
    endfor
endfunction

function! dashboard#menu#recentfiles#reset() abort
    let s:recent_files = []
    let s:recent_lines = []

    let lnum = search('^\s*\[1\]\s', 'nw')
    if lnum > 0
        execute lnum . ',$delete _'
    endif
endfunction

function! dashboard#menu#recentfiles#display() abort
    setlocal modifiable

    call dashboard#menu#recentfiles#reset()
    call dashboard#menu#recentfiles#get()
    call dashboard#menu#recentfiles#print()

    setlocal nomodifiable
endfunction

function! dashboard#menu#recentfiles#open(index) abort
    if exists('s:recent_files') && a:index < len(s:recent_files)
        execute 'edit ' . fnameescape(s:recent_files[a:index])
    endif
endfunction
