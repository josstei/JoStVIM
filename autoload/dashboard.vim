let s:dashboard  = []

function! dashboard#Open() abort
    call dashboard#buffer#Create()
    call dashboard#Build()
    call dashboard#Draw()
endfunction

function! dashboard#Build() abort
    if empty(s:dashboard)
        call extend(s:dashboard,g:dashboard_logo)
        call extend(s:dashboard,call('dashboard#menu#options', [g:dashboard_options]))
        call extend(s:dashboard,g:dashboard_extras)
    endif
endfunction

function! dashboard#Clear() abort
    silent! %delete _
endfunction

function! dashboard#Draw() abort
    setlocal modifiable
    call dashboard#Clear()
    call dashboard#Print()
    call cursor(1, 1)
    setlocal nomodifiable
endfunction

function! dashboard#Print() abort
    let s:pad_top   = max([0, float2nr((winheight(0) - len(s:dashboard)) / 2)])
    let s:width     = winwidth(0)
    let l:dashboard = map(copy(s:dashboard), {_, val -> repeat(' ', float2nr((s:width - strwidth(val)) / 2)) . val})

    call append(0, repeat([''], s:pad_top) + l:dashboard)
endfunction

function! dashboard#Resize() abort
    for winnr in range(1, winnr('$'))
        let bufnr = winbufnr(winnr)
        if getbufvar(bufnr, '&filetype') ==# 'dashboard'
            let curwin = winnr()
            execute winnr . 'wincmd w'
            call dashboard#Draw()
            execute curwin . 'wincmd w'
        endif
    endfor
endfunction
