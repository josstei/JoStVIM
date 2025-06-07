call plug#begin()
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'psliwka/vim-smoothie'       
Plug 'preservim/nerdtree'
Plug 'josstei/vim-jostline'
Plug 'josstei/vim-easyops'
Plug 'josstei/vim-tidyterm'
" ***** THEMES *****
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'crusoexia/vim-monokai'
Plug 'sainnhe/everforest'
Plug 'NLKNguyen/papercolor-theme'
call plug#end()


" **********************************************************
" ***************** GENERAL SETUP **************************
" **********************************************************
    if !has('nvim')
        set termwinsize=20x 
    endif
	" - DISPLAY LINE NUMBERS RELATIVE TO CURRENT LINE
	set relativenumber
	" - NOT CASE SENSITIVE FOR SEARCH 
	set ignorecase
	" - HIGHLIGHT LINE CURSOR IS CURRENTLY ON
	set cursorline
	" - TIMEOUT LENGTH BETWEEN KEYMAP KEYSTROKES ( IN MS )
	set timeoutlen=500 
	" - SET ENCODING FOR UTF - 8
	set encoding=UTF-8
	" - SET TAB TO 4 SPACES
	set ts=2 sw=2
	" - PREVENT SWAP FILE CREATION
	set noswapfile
	" - ALLOW SYSTEM CLIPBOARD IF APPLICABLE
	if has('clipboard')
	  set clipboard+=unnamedplus
	endif

" **********************************************************
" ***************** JOSTLINE SETUP *************************
" **********************************************************
	" Left Section
	let g:jostline_left_section_1_active = { 'items': ['windowNumber']}
	let g:jostline_left_section_2_active = { 'items': ['mode'] }
	let g:jostline_left_section_3_active = { 'items': ['gitStats']}
	let g:jostline_left_section_4_active = { 'items': ['fileName']}

	let g:jostline_left_section_1_inactive = { 'items': ['windowNumber']}

	" Right Section
	let g:jostline_right_section_1_active = { 'items': ['fileType'] }
	let g:jostline_right_section_2_active = { 'items': ['modified'] }
	let g:jostline_right_section_3_active = { 'items': ['cursorPos'] }

	let g:jostline_right_section_3_inactive= { 'items': ['fileName'] }

	" Separator 
	let g:jostline_separator = 'triangle'
	let g:jostline_subseparator = 'dot'

" **********************************************************
" ***************** NETRW SETUP ****************************
" **********************************************************
	let g:netrw_banner = 0
	" - PRESERVE CURRENT DIRECTORY
	let g:netrw_keepdir = 1
	" - TREE STYLE 
	let g:netrw_liststyle = 3
	" - SORT BY NAME 
	let g:netrw_sort_options ='1' 

" **********************************************************
" ***************** THEME START ****************************
" **********************************************************
	" THEME COMPATIBILITY
	set nocompatible
	if (has("termguicolors"))
	  set termguicolors
	endif
	syntax enable
	" SET COLORSCHEME 
	colorscheme catppuccin_mocha
	set fillchars=eob:\ 
	highlight EndOfBuffer ctermfg=NONE guifg=NONE
" **********************************************************
" ***************** FZF CONFIG *****************************
" **********************************************************
	" SET FZF BUFFER OPEN AT BOTTOM 
	let g:fzf_layout = {'down':'20%'}

	autocmd! FileType fzf
	autocmd FileType fzf set laststatus=0 noshowmode noruler
		\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

	function! FZFOpen(cmd)
		call NavigateToOpenWindow()
		exe a:cmd
	endfunction

" ********************************************************************
" ******************* WINDOW BUFFER BEHAVIOR START *******************
" ********************************************************************
let g:functionalBuffers = ['quickfix', 'help', 'nofile', 'terminal']

function! NavigateToOpenWindow()
	if IsFunctionalBuffer(bufnr('%'))
		let new_win_num = FindOpenWindow(GetAllOpenWindows())
		call DoNavigate(new_win_num)
	endif
endfunction

function! IsFunctionalBuffer(buffer)
	return index(g:functionalBuffers,getbufvar(a:buffer,"&bt")) >= 0
endfunction
	
function! GetAllOpenWindows()
	return filter(tabpagebuflist(),'(IsFunctionalBuffer(v:val) == 0) && (IsNewBuffer(v:val) == 1)')
endfunction

" - TODO ADD CHECK FOR MODIFIED
function! IsNewBuffer(buffer)
	return (bufname(a:buffer) == 'new') || ( bufname(a:buffer) == '')
endfunction

function! FindOpenWindow(arr)
	if !empty(a:arr) | return bufwinnr(a:arr[0]) | endif | return 0 
endfunction

function! GetAllFunctionalWindows()
	return filter(range(1,tabpagewinnr('$')),'(IsFunctionalBuffer(v:val) == 1)')
endfunction

function! DoNavigate(window)
	if a:window != 0 | execute ':'.a:window.'wincmd w ' | else | tabnew |endif	
endfunction
" ********************************************************************
" ******************* WINDOW BUFFER BEHAVIOR END *********************
" ********************************************************************

" ****** LEADER REMAPPING ******
nnoremap <space> <nop>
let mapleader = " " 

" **********************************************************
" ***************** NERD TREE SETUP ************************
" **********************************************************
" FORCE NERDTree TO ALWAYS OPEN ON THE LEFT WITH A WIDTH OF 31 COLUMNS
let g:nerdtree_tabs_smart_startup_focus = 1
let g:NERDTreeWinPos = 'left' 

autocmd FileType nerdtree vertical resize 31 

autocmd VimEnter * call OnVimEnter() 
autocmd TabNew * call TriggerTree() 

function! OnVimEnter()
	if argc() == 0 || (argc() == 1 && isdirectory(argv(0)))
 		call ShowDefault()
	endif
	call TriggerTree()
endfunction

function! TriggerTree()
	NERDTree | wincmd p 
endfunction

" - TOGGLE OPEN/CLOSE TREE 
nnoremap <leader>e :NERDTreeToggle<CR>
" - REMOVE TOP HELP MESSAGE
let NERDTreeMinimalUI = 1

" **********************************************************
" ***************** TERMINAL SETUP *************************
" **********************************************************
" - OPEN TERMINAL AT BOTTOM 
nnoremap <leader>t :botright term ++close<CR>
" - CLEAR AND CLOSE TERMINAL BUFFER 
tnoremap <c-d> :Tclear<CR><c-d>
" - SET TERMINAL INTO SCROLL MODE
tnoremap <c-n> <c-\><c-n>

" **********************************************************
" ***************** FILE SETUP *****************************
" **********************************************************
" - FILE QUIT
nnoremap <leader>fq :q<CR>
nnoremap <leader>fs :w<CR>
" - FILE FORCE QUIT
nnoremap <leader>FQ :q!<CR>
" - FILE FORCE QUIT ALL ******
nnoremap <leader>bye :qa!<CR>

" **********************************************************
" ***************** WINDOW NAV START ***********************
" **********************************************************

	" WINDOW SPLIT ( VERTICAL )
	nnoremap <leader>wv :rightbelow vs new<CR>
	" WINDOW SPLIT ( HORIZONTAL )
	nnoremap <leader>wh :rightbelow split new<CR>
	" WINDOW NAVIGATION
	nnoremap <leader>1 :1wincmd w<CR>
	nnoremap <leader>2 :2wincmd w<CR>
	nnoremap <leader>3 :3wincmd w<CR>
	nnoremap <leader>4 :4wincmd w<CR>
	nnoremap <leader>5 :5wincmd w<CR>
	nnoremap <leader>6 :6wincmd w<CR>

" **********************************************************
" ***************** FILE / TEXT SEARCH START ***************
" **********************************************************

	" SEARCH CWD FILES
	nnoremap <leader><leader> :call FZFOpen(':Files')<CR>
	" SEARCH CWD TEXT
	nnoremap <leader>t :SearchText<CR>

	function! SearchTextInCurrentDir()
		let l:searchText = input('Search For Text (Current Directory): ')

		if empty(l:searchText) | echo "Cancelled." | return | endif

		let l:cmd = 'grep -rniI --exclude-dir=.git ' . shellescape(l:searchText) . ' ' . shellescape(getcwd())
		let l:results = systemlist(l:cmd)

		if empty(l:results)
			echo '  - No Matches Found - '
			return
		endif

		call setqflist([], 'r', {'lines':l:results,'title':'Search Results'})
		copen
	endfunction

	command! SearchText call SearchTextInCurrentDir()
	autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

" ****** EXIT INSERT MODE ****** 
inoremap jk <ESC> 

" Map <leader>lt to run all Vader tests under tests/
nnoremap <leader>lt :Vader --verbose tests/*.vader<CR>


" **********************************************************
" ***************** COMMENT SETUP **************************
" **********************************************************
" - COMMENT SYNTAX BY LANGUAGE
let g:comment_map = {
      \ 'c':        '// ',
      \ 'cpp':      '// ',
      \ 'java':     '// ',
      \ 'scala':    '// ',
      \ 'sh':       '# ',
      \ 'ruby':     '# ',
      \ 'python':   '# ',
      \ 'conf':     '# ',
      \ 'fstab':    '# ',
      \ 'tex':      '% ',
      \ 'mail':     '> ',
      \ 'vim':      '" '
      \ }

" Function to get the comment string based on the current filetype
function! GetComment()
  return get(g:comment_map, &filetype, '# ')
endfunction
" Mappings for commenting/uncommenting
noremap <leader>cc :<C-B>silent s/^/<C-R>=escape(GetComment(), '/')<CR>/<CR> :nohlsearch<CR>
noremap <leader>cu :<C-B>silent s/^\V<C-R>=escape(GetComment(), '/')<CR>//e<CR> :nohlsearch<CR>
" Mappings for commenting
vnoremap <leader>cc :<C-U>silent '<,'>s/^/<C-R>=escape(GetComment(), '/')<CR>/<CR> :nohlsearch<CR>
vnoremap <leader>cu :<C-U>silent '<,'>s/^\V<C-R>=escape(GetComment(), '/')<CR>//e<CR> :nohlsearch<CR>

function! ShowDefault()
	enew
  let l:default= [
        \ '{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}',
        \ '{}                                                                                          {}',
        \ '{}                                                                                          {}',
        \ '{}            █████           █████████   █████    █████   █████ █████ ██████   ██████      {}',
        \ '{}           ░░███           ███░░░░░███ ░░███    ░░███   ░░███ ░░███ ░░██████ ██████       {}',
        \ '{}            ░███   ██████ ░███    ░░░  ███████   ░███    ░███  ░███  ░███░█████░███       {}',
        \ '{}            ░███  ███░░███░░█████████ ░░░███░    ░███    ░███  ░███  ░███░░███ ░███       {}',
        \ '{}            ░███ ░███ ░███ ░░░░░░░░███  ░███     ░░███   ███   ░███  ░███ ░░░  ░███       {}',
        \ '{}      ███   ░███ ░███ ░███ ███    ░███  ░███ ███  ░░░█████░    ░███  ░███      ░███       {}',
        \ '{}     ░░████████  ░░██████ ░░█████████   ░░█████     ░░███      █████ █████     █████      {}',
        \ '{}      ░░░░░░░░    ░░░░░░   ░░░░░░░░░     ░░░░░       ░░░      ░░░░░ ░░░░░     ░░░░░       {}',
        \ '{}                                                                                          {}',
        \ '{}                                                                                          {}',
        \ '{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}',
        \ '',
        \ "═══════════════════════════════════════ QUICK START ══════════════════════════════════════════",
        \ "                                            "."                                               ",
        \ "🧭 WINDOW NAVIGATION                        "." 🖊 FILE SAVE/QUIT                             ",
        \ " ▶ <space> 1-6 → Focus to window number     "." ▶ <Space> fs  → Save buffer                   ",
        \ " ▶ <space> wv  → Split window (vertical)    "." ▶ <Space> fq  → Close buffer                  ",
        \ " ▶ <space> wh  → Split window (horizontal)  "." ▶ <Space> ffq → Force quit buffer             ",
        \ "                                            "." ▶ <Space> bye → Force quit all/Exit JoStVIM   ",
        \ " 📂 SEARCHING FILES/TEXT                    "."                                               ", 
        \ " ▶ <space><space> → Search All Files        "." 🗂 TERMINAL                                   ", 
        \ " ▶ <space> /      → Search All Text         "." ▶ <Space> t  → Open terminal                  ",
        \ "                                            "." ▶ <Ctrl + d> → Closeterminal                  ",
        \ " 📝 COMMENT CODE                            "."                                               ",
        \ " ▶ <Space> cc → Comment line/selection      "."                                               ",
        \ " ▶ <Space> cu → Uncomment line/selection    "."                                               ",
        \ "                                            "."                                               ",
        \ "══════════════════════════════════════════════════════════════════════════════════════════════"
        \ ]

  call setline(1, l:default)
  setlocal buftype= bufhidden=hide noswapfile
  setlocal nomodifiable
endfunction

" ********** JAVA SETUP START **********
set nocompatible
syntax on
filetype plugin indent on

set number
set tabstop=4 shiftwidth=4 expandtab
set autoindent
set smartindent

autocmd FileType java setlocal omnifunc=s:javacomplete

function! s:javacomplete(findstart, base)
  if a:findstart
    let line  = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\w'
      let start -= 1
    endwhile
    return start
  else
    return ['toString()', 'equals()', 'hashCode()', 'notify()', 'wait()']
  endif
endfunction

" autocmd BufWritePost *.java call s:RunJavac()

function! s:RunJavac()
  let l:filename = expand('%:p')
  let l:errors   = systemlist('javac ' . shellescape(l:filename))
  call setqflist(map(copy(l:errors), '{ "text": v:val }'))
  if len(l:errors)
    botright copen
  else
    cclose
  endif
endfunction

syntax match JavaTodoComment /\/\/\s*TODO.*/ containedin=javaComment
highlight link JavaTodoComment Todo

" ********** JAVA SETUP END **********

" ********* EASYOPS CONFIG START ***********
let g:easyops_commands_main = [
    \ { 'label' : 'Git',    'command':'menu:git' },
    \ { 'label' : 'Window', 'command':'menu:window' },
    \ { 'label' : 'File',   'command':'menu:file' },
    \ { 'label' : 'Code',   'command':'menu:code' },
    \ { 'label' : 'Misc',   'command':'menu:easyopsconfig' }
    \ ]
let g:easyops_commands_code = [
    \ { 'label' : 'Maven',  'command':'menu:springboot|maven' },
    \ { 'label' : 'Vim',    'command':'menu:vim' }
    \ ]

nnoremap <silent> <Space>/ :TidyTerm<CR>
tnoremap <silent> <Space>/ <C-\><C-n>:TidyTerm<CR>

