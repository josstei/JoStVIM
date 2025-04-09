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

" TODO use a map for highlight for fg and bg
let g:sl_leftSide = {
			\'section_1':{'items':['windowNumber'],'highlight':'#c678dd'},
			\'section_2':{'items':['mode'],'highlight':'#4b2a55'},
			\'section_3':{'items':['fileName'],'highlight':'#c678dd'},
			\'separator':'',
			\'side':'LEFT'
			\}

let g:sl_rightSide = {
			\'section_1':{'items':[],'highlight':'#c678dd'},
			\'section_2':{'items':[],'highlight':'#4b2a55'},
			\'section_3':{'items':[],'highlight':'#c678dd'},
			\'separator':'',
			\'side':'RIGHT'
			\}

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
	let l:leftGroup  = SL_ParseStatuslineMap(g:sl_leftSide)
	let l:rightGroup = SL_ParseStatuslineMap(g:sl_rightSide)

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
	elseif a:item ==# 'fileName' 
		return SL_GetFilename()
	elseif a:item ==# 'fileType' 
		return SL_GetFiletype()
	elseif a:item ==# 'windowNumber' 
		return SL_GetWindowNumber()
	else
		return ''
	endif
endfunction

function! SL_ParseStatuslineMap(map) 

	let section_1 = get(a:map,'section_1',v:null)
	let section_2 = get(a:map,'section_2',v:null)
	let section_3 = get(a:map,'section_3',v:null)
	let side 	  = get(a:map,'side',v:null)
	let separator = get(a:map,'separator',v:null)
	
	return SL_ParseSectionGroup(section_1,section_2,section_3,side,separator)	
endfunction

function! SL_ParseSectionItems(items)
	let l:arrItemValues = []	
	
	for i in range(len(a:items))
		call add(l:arrItemValues,SL_GetItemValue(a:items[i]))
	endfor

	return join(l:arrItemValues,'')
endfunction


function! SL_ParseSectionGroup(section_1,section_2,section_3,side,separator) 
	let groupItems 	 = [] 
	let arrSections 	 = [a:section_1,a:section_2,a:section_3]

	for i in range(len(l:arrSections))
		let section   	     = l:arrSections[i]
		let sectionItems 	 = SL_ParseSectionItems(get(section,'items',v:null))
		let sectionHighlight = get(section,'highlight',v:null)
		" test until I finish this up
		let test = SL_ApplySectionHighlight(i + 1,sectionItems,a:side,a:separator)
		
		if sectionItems != ''
			call add(groupItems,test)
		endif
	endfor
	
	return join(groupItems, '')
endfunction

function! SL_ApplySectionHighlight(section,sectionItems,side,separator) 
	"test for now 
	let testItem = SL_ApplyItemHighlight(a:sectionItems)

	return  a:side == 'LEFT'  ? testItem. a:separator:
		   \a:side == 'RIGHT' ? a:separator . a:sectionItems:
		   \v:null
endfunction

function! SL_ApplySeparatorHighlight(sectionNum,separator,group) 
	return '%#SECTION_'.a:sectionNum.'_'.a:group.'_SEPARATOR#'.a:separator.'%*'		
endfunction

" test for now
function! SL_ApplyItemHighlight(sectionItems) 
	return '%#Section_1_Left# '.a:sectionItems.'%*'		
endfunction

function! SL_SetHighlights()
	let fg_color = '#000000'
	let bg_color = '#c678dd'
   	let style = 'bold'
	" testing for just section 1 for now
	let hl_cmd = printf('highlight Section_1_Left guifg=%s guibg=%s gui=%s', fg_color, bg_color, style)
	
	execute hl_cmd
endfunction

set statusline=%!SL_Set()

augroup StatusLine au! 
	au WinEnter,WinLeave,WinNew * redrawstatus!
	autocmd ColorScheme * call SL_SetHighlights()
augroup END

autocmd FileType * setlocal statusline=%!SL_Set()

