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

let g:statusline_config = {
			\ 'left': {
			\   'section_1': { 'items': ['windowNumber'], 'highlight': {'bg': '#c678dd', 'fg': ''} },
			\   'section_2': { 'items': ['mode'],         'highlight': {'bg': '#c678dd', 'fg': ''} },
			\   'section_3': { 'items': ['fileName'],     'highlight': {'bg': '#c678dd', 'fg': ''} },
			\   'separator': '',
			\   'side': 'LEFT'
			\ },
			\ 'right': {
			\   'section_1': { 'items': ['someOtherItem'], 'highlight': {'bg': '#c678dd', 'fg': ''} },
			\   'section_2': { 'items': ['anotherItem'],   'highlight': {'bg': '#c678dd', 'fg': ''} },
			\   'section_3': { 'items': ['yetAnotherItem'],  'highlight': {'bg': '#c678dd', 'fg': ''} },
			\   'separator': '',
			\   'side': 'RIGHT'
			\ }
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
	let is_active = g:statusline_winid == win_getid()
	let cfg = deepcopy(g:statusline_config)

	if !is_active
		if has_key(cfg.left, 'section_1')
			let cfg.left.section_1.items = ['windowNumber']
		endif
		if has_key(cfg.left, 'section_2')
			let cfg.left.section_2.items = []
		endif
		if has_key(cfg.left, 'section_3')
			let cfg.left.section_3.items = []
		endif
	endif

  return ''.ParseSectionGroup(cfg.left).'%='.ParseSectionGroup(cfg.right).' '
endfunction

function! GetMode() 
	return get(g:mode_map, mode(), 'UNKNOWN MODE')
endfunction

function! GetFilename() 
	return expand('%:t') ==# '' ? '[No Name]' : expand('%:t') 
endfunction

function! GetFiletype() 
	return '%{&filetype}'
endfunction

function! GetWindowNumber() 
	return '%{winnr()}'
endfunction

function! GetModified() 
	return &modified ? '[+]' : ''
endfunction

function! GetItemValue(item)
	let l:itemValueMap = {
		\ 'mode':         GetMode(),
		\ 'fileName':     GetFilename(),
		\ 'fileType':     GetFiletype(),
		\ 'windowNumber': GetWindowNumber()
		\ }
	return has_key(l:itemValueMap, a:item) ? l:itemValueMap[a:item] : v:null 
endfunction

function! ParseSectionItems(items)
	let l:itemValues = filter(map(copy(a:items),'GetItemValue(v:val)'), 'v:val !=v:null' )
	return empty(l:itemValues) ? v:null : join(l:itemValues, '')
endfunction

function! GetSections(map)
	return filter(copy(a:map), 'v:key =~# "^section_\\d\\+$"')
endfunction

function! ParseSectionGroup(map)
	let l:groupMap = a:map
  	let l:sections = GetSections(l:groupMap)
  	let l:separator = l:groupMap ->get('separator','')
	let l:side = l:groupMap ->get('side','')
	let l:parts = []

	for [name, data] in items(l:sections)
	   	let l:itemsStr = ParseSectionItems(data.items)
		let l:highlighted = AppendHighlights(name, l:itemsStr, l:side, l:separator)

		if l:highlighted != v:null
			call add(l:parts,l:highlighted)
		endif
	endfor
  return empty(l:parts) ? '' : join(l:parts, '')
endfunction

function! AppendHighlights(name,items,side,separator) 
	if a:items == v:null 
		return a:items
	endif

	let l:items = AppendItemHighlight(a:name,a:items,a:side)
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

augroup StatusLine
	autocmd!
	autocmd ColorScheme * call TestSectionHighlights()
augroup END



