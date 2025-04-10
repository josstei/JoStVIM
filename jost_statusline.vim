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
			\'section_1':{'items':['windowNumber'],'highlight':{'bg':'#c678dd','fg':''}},
			\'section_2':{'items':['mode'],'highlight':{'bg':'#c678dd','fg':''}},
			\'section_3':{'items':['fileName'],'highlight':{'bg':'#c678dd','fg':''}},
			\'separator':'',
			\'side':'LEFT'
			\}

let g:sl_rightSide = {
			\'section_1':{'items':[''],'highlight':{'bg':'#c678dd','fg':''}},
			\'section_2':{'items':[''],'highlight':{'bg':'#c678dd','fg':''}},
			\'section_3':{'items':[''],'highlight':{'bg':'#c678dd','fg':''}},
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
	return ''.ParseSectionGroup(g:sl_leftSide).'%='.ParseSectionGroup(g:sl_rightSide).' '
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
		return v:null 
	endif
endfunction

function! ParseSectionItems(items)
	let l:arrItemValues = []	
	
	for i in range(len(a:items))
		let test = SL_GetItemValue(a:items[i])
		if test != v:null
			call add(l:arrItemValues,test)
		endif
	endfor
	
	return !empty(arrItemValues) ? join(arrItemValues, '') : v:null
endfunction

function! GetSections(map)
    return filter(copy(a:map), 'v:key =~# "^section_\\d\\+$"')
endfunction

function! ParseSectionGroup(map)
	let groupItems 	= [] 
	let sections 	= GetSections(a:map)
	let separator 	= a:map->get('separator','')
	let side 		= a:map->get('side','')

	for [name, data] in items(sections)
		let items = AppendHighlights(name,ParseSectionItems(data.items),side,separator)
		if items != v:null
			call add(groupItems,items)
		endif
	endfor
	return !empty(groupItems) ? join(groupItems, '') : ''
endfunction

function! AppendHighlights(name,items,side,separator) 
	if a:items == v:null 
		return a:items
	endif
	"test for now 
	let l:items 	= AppendItemHighlight(a:name,a:items,a:side)
	let l:separator = AppendSeparatorHighlight(a:name,a:separator,a:side) 

	return  a:side == 'LEFT'  ? l:items.l:separator:
		   \a:side == 'RIGHT' ? l:separator.l:items:
		   \v:null
endfunction

function! AppendItemHighlight(name,items,side) 
	return '%#'.a:name.'_'.a:side.'# '.a:items.'%*'		
endfunction

function! AppendSeparatorHighlight(name,separator,side) 
	return '%#'.a:name.'_'.a:side.'_separator#'.a:separator.'%*'		
endfunction

function! TestSectionHighlights()
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
	autocmd ColorScheme * call TestSectionHighlights()
augroup END

autocmd FileType * setlocal statusline=%!SL_Set()

