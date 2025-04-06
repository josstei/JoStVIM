let g:mode_map = {
  \ 'n': 'NORMAL',          
  \ 'i': 'INSERT',              
  \ 'R': 'REPLACE',           
  \ 'v': 'VISUAL',               
  \ 'V': 'VISUAL LINE',      
  \ '^V': 'VISUAL BLOCK',       
  \ 'c': 'COMMAND',            
  \ 'C': 'COMMAND-LINE',          
  \ 's': 'SELECT',                
  \ 'S': 'SELECT LINE',          
  \ 't': 'TERMINAL',             
  \ 'nI': 'NORMAL INSERT',       
  \ 'N': 'INSERT NORMAL',         
  \ 'N:': 'NORMAL EX',            
  \ 'iN': 'INSERT NORMAL',        
  \ 'p': 'PREVIEW',               
  \ 'l': 'LITERAL',              
  \ 'R?': 'REPLACE MODE',         
  \ 'o': 'OPERATOR-PENDING',      
  \ 'O': 'OPERATOR PENDING',      
  \ 'r': 'REPEAT',                
  \ 'a': 'ARGUMENT',              
  \}

function! SL_Set()
  let l:mode = SL_GetMode(mode())
  let l:file = expand('%:t') ==# '' ? '[No Name]' : expand('%:t')
  let l:modified = &modified ? '[+]' : ''

  return '%#StatusLine#' .
        \ '%{winnr()}' .
        \ ' ' . l:mode .
        \ ' | ' . l:file . ' ' . l:modified .
        \ '%=' .
        \ '%{&filetype} | %l:%c '
endfunction

function SL_GetMode(mode)
	return get(g:mode_map, a:mode, 'UNKNOWN MODE') 
endfunction

function SL_GetWindowState(mode)
	return get(g:mode_map, a:mode, 'UNKNOWN MODE') 
endfunction

set statusline=%!SL_Set()

augroup StatusLine
    au!
    au WinEnter,WinLeave,WinNew * redrawstatus!
augroup END

autocmd FileType * setlocal statusline=%!SL_Set()
