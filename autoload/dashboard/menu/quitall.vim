function! dashboard#menu#quitall#command() abort
    return { "keymap":"q", "label":"Quit", "command":":qa <CR>" }
endfunction
