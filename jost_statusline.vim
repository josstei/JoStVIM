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

" Plan to properly handle these with maps vs the brute force way below
let g:sl_leftSide = {
			\'section_1':{'items':['windowNumber'],'color':'#c678dd'},
			\'section_2':{'items':['mode'],'color':'#4b2a55'},
			\'section_3':{'items':['fileName'],'color':'#c678dd'},
			\'separator':'',
			\}

let g:sl_rightSide = {
			\'section_1':{'items':[]},
			\'section_2':{'items':[]},
			\'section_3':{'items':['filetype']},
			\'separator':'',
			\}

let g:sl_section_1_left = { 
			\ 'windownumber':1,
			\}

let g:sl_section_2_left = { 
			\ 'mode':1, 
			\}

let g:sl_section_3_left = { 
			\ 'filename':1,
			\}

let g:sl_section_1_right = { 
			\}

let g:sl_section_2_right = {
			\ 'filetype':1,
			\}
let g:sl_section_3_right = { 
			\}

let g:sl_section_left_separator  = ''
let g:sl_section_right_separator = ''


augroup StatusLineOverrides
	autocmd!
	autocmd ColorScheme * highlight Section_1_Left 			 guifg=#000000 guibg=#c678dd
	autocmd ColorScheme * highlight Section_1_Left_Separator guifg=#c678dd guibg=#4b2a55
	autocmd ColorScheme * highlight Section_2_Left 			 guifg=#efd7f6 guibg=#4b2a55
	autocmd ColorScheme * highlight Section_2_Left_Separator guifg=#4b2a55 guibg=#333333
	autocmd ColorScheme * highlight Section_3_Left 			 guifg=#ffffff guibg=#333333
	autocmd ColorScheme * highlight Section_3_Left_Separator guifg=#333333 guibg=#333333 
	autocmd ColorScheme * highlight Section_1_Right guifg=#000000 guibg=#2a9df4
	autocmd ColorScheme * highlight Section_2_Right guifg=#000000 guibg=#2a9df4
	autocmd ColorScheme * highlight Section_3_Right guifg=#000000 guibg=#2a9df4
augroup END


function! SL_Set() 
	" let l:modified = &modified ? '[+]' : ''
	let l:leftGroup  = SL_ParseSectionGroup(g:sl_section_1_left,g:sl_section_2_left,g:sl_section_3_left,'LEFT')	
	let l:rightGroup = SL_ParseSectionGroup(g:sl_section_1_right,g:sl_section_2_right,g:sl_section_3_right,'RIGHT')	
	 
	return '' . l:leftGroup . '%=' . l:rightGroup . ' '

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

function! SL_GetModified() 
	return &modified ? '[+]' : ''
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
	
	return !empty(l:items) ? join(l:items,' ') : v:null
endfunction

function! SL_ParseSectionGroup(section_1,section_2,section_3,group) 
	let l:sideItems =  [] 
	let l:arrSections = [a:section_1,a:section_2,a:section_3]

	for i in range(len(l:arrSections))
		let sectionItems = SL_ParseSectionItems(l:arrSections[i])
	
		if sectionItems != v:null
			let sectionItems = SL_ApplySectionHighlight(i + 1,sectionItems,a:group)
			call add(l:sideItems,sectionItems)
		endif
	endfor
	
	return join(l:sideItems, '')
endfunction

function! SL_ApplySectionHighlight(sectionNum,items,group) 
	let l:leftSeparator  = SL_ApplySeparatorHighlight(a:sectionNum,g:sl_section_left_separator,a:group)	
	let l:rightSeparator = SL_ApplySeparatorHighlight(a:sectionNum,g:sl_section_right_separator,a:group)	
	let l:sectionItems   = SL_ApplyItemHighlight(a:sectionNum,a:items,a:group)

	if a:group ==# 'LEFT'
		return l:sectionItems.l:leftSeparator
	else
		return l:rightSeparator.l:sectionItems
	endif
endfunction

function! SL_ApplySeparatorHighlight(sectionNum,separator,group) 
	return '%#SECTION_'.a:sectionNum.'_'.a:group.'_SEPARATOR#'.a:separator.'%*'		
endfunction

function! SL_ApplyItemHighlight(sectionNum,item,group) 
	return '%#SECTION_'.a:sectionNum.'_'.a:group.'# '.a:item.'%*'		
endfunction


set statusline=%!SL_Set()

augroup StatusLine au! 
	au WinEnter,WinLeave,WinNew * redrawstatus!
augroup END

autocmd FileType * setlocal statusline=%!SL_Set()

