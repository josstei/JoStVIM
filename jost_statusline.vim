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

let g:sl_section_1_left = { 
			\ 'windownumber':1,
			\}

let g:sl_section_2_left = { 
			\ 'mode':1, 
			\ 'filename':1,
			\}

let g:sl_section_3_left = { 
			\}

let g:sl_section_1_right = { 
			\ 'filetype':1,
			\}

let g:sl_section_2_right = {}

let g:sl_section_3_right = {}

function! SL_Set() 
	" let l:modified = &modified ? '[+]' : ''

	let l:leftGroup  = SL_ParseSectionGroup(g:sl_section_1_left,g:sl_section_2_left,g:sl_section_3_left)	
	let l:rightGroup = SL_ParseSectionGroup(g:sl_section_1_right,g:sl_section_2_right,g:sl_section_3_right)	
 
	return ' ' . l:leftGroup . '%=' . l:rightGroup . ' '

 endfunction

function! SL_GetMode() 
	return get(g:mode_map, mode(), 'UNKNOWN MODE')
endfunction

function! SL_GetFilename() 
	return expand('%:t') ==# '' ? '[No Name]' : expand('%:t') 
endfunction

function! SL_GetFiletype() 
	return '%{&filetype}'
endfunction

function! SL_GetWindowNumber() 
	return '%{winnr()}'
endfunction

function! SL_GetItemValue(item) 
	if a:item ==# 'mode'
		return SL_GetMode()
	elseif a:item ==# 'filename' 
		return SL_GetFilename()
	elseif a:item ==# 'filetype' 
		return SL_GetFiletype()
	elseif a:item ==# 'windownumber' 
		return SL_GetWindowNumber()
	endif
endfunction

function! SL_ParseItemMap(map) 
	if type(a:map) != type({}) | return [] | endif

 	let l:items = []

 	for [key, val] in items(a:map) 
		call add(l:items, [key, val == 1])
	endfor

 	return l:items 
endfunction

function! SL_ParseSectionItems(section)
	let l:items = []
	let l:sectionItems = SL_ParseItemMap(a:section)
	
	for [key, val] in l:sectionItems 
		call add(l:items,SL_GetItemValue(key))
	endfor 
	
	return !empty(l:items) ? join(l:items,' | ') : v:null
endfunction

function! SL_ParseSectionGroup(section_1,section_2,section_3) 
	let l:sideItems =  [] 
	let l:arrSections = [a:section_1,a:section_2,a:section_3]

	for section in l:arrSections
		let sectionItems = SL_ParseSectionItems(section)

		if sectionItems != v:null
			call add(l:sideItems,sectionItems)
		endif
	endfor
	
	return join(l:sideItems, ' # ')
endfunction

set statusline=%!SL_Set()

augroup StatusLine au! 
	au WinEnter,WinLeave,WinNew * redrawstatus!
augroup END

autocmd FileType * setlocal statusline=%!SL_Set()

