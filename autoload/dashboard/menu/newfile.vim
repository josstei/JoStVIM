function! dashboard#menu#newfile#command() abort
    return { "keymap":"n", "label":"New File", "command":":enew<CR>" }
endfunction
