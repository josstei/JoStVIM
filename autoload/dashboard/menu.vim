function! dashboard#menu#options(modules) abort
    let s:menu_options  = []
    let s:menu_width    = 26 

    for name in a:modules
        let l:func  = 'dashboard#menu#' . name . '#'
        let l:info  = call(function(l:func . 'command'), [])

        if has_key(l:info, 'keymap') && has_key(l:info, 'command')
            let l:label     = get(l:info, 'label', substitute(name, '\v\w+', '\u\0', 'g'))
            let l:text      = printf('[%s]  %s', l:info.keymap, l:label)
            let l:padded    = '      ' . l:text . repeat(' ', max([0, s:menu_width - strwidth(l:text)]))

            call add(s:menu_options, l:padded)

            execute printf('nnoremap <silent> <buffer> %s %s', l:info.keymap, l:info.command)
        endif
    endfor

    return s:menu_options + ['']
endfunction
