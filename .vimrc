call plug#begin()
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'psliwka/vim-smoothie'       
Plug 'preservim/nerdtree'
call plug#end()

source ~/.vim/jost_statusline.vim

" **********************************************************
" ***************** GENERAL SETUP **************************
" **********************************************************
	" - DISPLAY LINE NUMBERS RELATIVE TO CURRENT LINE
	set relativenumber
	" - NOT CASE SENSITIVE FOR SEARCH 
	set ignorecase
	" - HIGHLIGHT LINE CURSOR IS CURRENTLY ON
	set cursorline
	" - TIMEOUT LENGTH BETWEEN KEYMAP KEYSTROKES ( IN MS )
	set timeoutlen=500 
	" - TERMINAL DISPLAYS 10 ROWS 
	set termwinsize=10x 
	" - ALLOW MOUSE SUPPORT ( yuck )
	set mouse=a
	" - SET ENCODING FOR UTF - 8
	set encoding=UTF-8
	" - SET TAB TO 4 SPACES
	set ts=4 sw=4
	" - PREVENT SWAP FILE CREATION
	set noswapfile
	" - SHOW STATUSLINE ON ALL WINDOWS
	set laststatus=2

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
	colorscheme onedark

" **********************************************************
" ***************** FZF CONFIG *****************************
" **********************************************************
	" SET FZF BUFFER OPEN AT BOTTOM 
	let g:fzf_layout = {'down':'30%'}

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
let g:NERDTreeWinPos = "left" 

autocmd FileType nerdtree vertical resize 31 
autocmd FileType nerdtree setlocal statusline=%!SL_Set()

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
	nnoremap <leader>/ :SearchText<CR>

	function! SearchTextInCurrentDir()
		let l:searchText = input('Search For Text (Current Directory): ')

		if empty(l:searchText) | echo "Cancelled." | return | endif

		execute 
			\'vimgrep /' . escape(l:searchText, '/\') . 
			\'/j ' . join(split(system('find ' . getcwd() . ' -type f -name "*"'), "\n"))
		copen
	endfunction

	command! SearchText call SearchTextInCurrentDir()
	autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

" ****** EXIT INSERT MODE ****** 
inoremap jk <ESC> 

" **********************************************************
" ***************** JAVA SETUP - MAVEN *********************
" **********************************************************
" - MAVEN CLEAN
nnoremap mac :botright term ++close<CR>mvn clean<CR>
" - MAVEN INSTALL
nnoremap mai :botright term ++close<CR>mvn install<CR>
" - MAVEN SPRING BOOT RUN
nnoremap msb :botright term ++close<CR>mvn spring-boot:run<CR>

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
