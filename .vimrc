call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'psliwka/vim-smoothie'       
Plug 'preservim/nerdtree'
call plug#end()

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
" ***************** THEME SETUP ****************************
" **********************************************************
" - THEME COMPATIBILITY
set nocompatible
 if (has("termguicolors"))
   set termguicolors
 endif
 syntax enable
" - set colorscheme 
colorscheme onedark

" **********************************************************
" ***************** FZF CONFIG *****************************
" **********************************************************
" - SET FZF BUFFER OPEN AT BOTTOM 
let g:functionalBuffers = ['quickfix', 'help', 'nofile', 'terminal', 'nerdtree']
let g:fzf_layout = {'down':'30%'}

autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 noshowmode noruler
	\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

function! FZFOpen(cmd)
	call NavigateToOpenBuffer()
    exe a:cmd
endfunction

function! NavigateToOpenBuffer()
	if IsFunctionalBuffer(&bt)
		execute ':'.SearchAnchor(GetActiveBuffers(),0).'wincmd w '
	endif
endfunction

function! IsFunctionalBuffer(bt)
	return index(g:functionalBuffers,a:bt) >= 0
endfunction
	
function! GetActiveBuffers()
	return filter(range(1,bufnr('$')), 'bufwinnr(v:val) > 0')
endfunction

function! SearchAnchor(arr,i)
	try
		let buf_type = getbufvar(a:arr[a:i], '&bt')
		let buf_num = bufnr(a:arr[a:i])
		let buf_win = bufwinnr(buf_num)

		return (IsFunctionalBuffer(buf_type) == 0) && (buf_win > 0) ? buf_win : SearchAnchor(a:arr,a:i +1)
	catch
		return 0
	endtry
endfunction

" ****** LEADER REMAPPING ******
nnoremap <space> <nop>
let mapleader = " " 

" **********************************************************
" ***************** NERD TREE SETUP ************************
" **********************************************************
" FORCE NERDTree TO ALWAYS OPEN ON THE LEFT WITH A WIDTH OF 31 COLUMNS
autocmd FileType nerdtree vertical resize 31

autocmd VimEnter * call OnVimEnter() 

function! OnVimEnter()
	if argc() == 0 || (argc() == 1 && isdirectory(argv(0)))
		call ShowDefault()
	endif
	call TriggerTree()
endfunction

" function! OnBufferEnter()
" 	let totalWin = winnr('$')
" 	let prevBufName = bufname('#')
" 	let currBufName = bufname('%')
" 	let isHeadBuf = winnr() == winnr('h')
" 	let treeRegex = 'NERD_tree_.*'
" endfunction

function! TriggerTree()
	NERDTree
	wincmd p
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
" - BUFFER DELETE
nnoremap <leader>bd :bd<CR>

" **********************************************************
" ***************** FILE SETUP *****************************
" **********************************************************
" - FILE QUIT
nnoremap <leader>fq :q<CR>
" - FILE FORCE QUIT
nnoremap <leader>ffq :q!<CR>
" - FILE FORCE QUIT ALL ******
nnoremap <leader>bye :qa!<CR>
" - FILE SAVE
nnoremap <leader>fs :w<CR>

" **********************************************************
" ***************** WINDOW SETUP ***************************
" **********************************************************
" - WINDOW SPLIT ( VERTICAL )
nnoremap <leader>wv :rightbelow vs new<CR>
" - WINDOW SPLIT ( HORIZONTAL )
nnoremap <leader>wh :rightbelow split new<CR>
" - WINDOW NAVIGATION ( LEFT BUFFER )
nnoremap <c-h> <c-w>h
" - WINDOW NAVIGATION ( DOWN BUFFER )
nnoremap <c-j> <c-w>j
" - WINDOW NAVIGATION ( UP BUFFER )
nnoremap <c-k> <c-w>k
" - WINDOW NAVIGATION ( RIGHT BUFFER )
nnoremap <c-l> <c-w>l

" **********************************************************
" ***************** PROJECT SETUP **************************
" **********************************************************
" - SEARCH PROJECT FILES ( ALL ) 
nnoremap <leader>pf :call FZFOpen(':FZF')<CR>
" - SEARCH PROJECT FILES ( GIT TRACKED ) 
nnoremap <leader>pg :call FZFOpen(':GFiles')<CR>

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
        \ "",
        \ "🧭 WINDOW NAVIGATION                     📂 SEARCHING FILES                  🖊 FILE SAVE/QUIT",
        \ "   ▶ <Space> e → Toggle file explorer       ▶ <Space> pf → Search project       ▶ <Space> fs  → Save buffer       ",
        \ "   ▶ <Ctrl> h → Left buffer                 ▶ <Space> pg → Search Git files     ▶ <Space> fq  → Close buffer      ",
        \ "   ▶ <Ctrl> j → Below buffer                                                    ▶ <Space> ffq → Force quit buffer ",
        \ "   ▶ <Ctrl> k → Above buffer             🗂 TERMINAL                            ▶ <Space> bye → Force quit all/Exit JoStVIM",
        \ "   ▶ <Ctrl> l → Right buffer                ▶ <Space> t  → Open terminal                                          ",
        \ "   ▶ <Space> wv → Split Vert.               ▶ <Ctrl + d> → Closeterminal                                           ",
        \ "   ▶ <Space> wh → Split Hor.                                                                                 ",
        \ "                                                                                                             ",
        \ "📝 COMMENT CODE",
        \ "   ▶ <Space> cc → Comment line/selection",
        \ "   ▶ <Space> cu → Uncomment line/selection",
        \ "                                                                                                             ",
        \ "══════════════════════════════════════════════════════════════════════════════════════════════"
        \ ]

  call setline(1, l:default)
  setlocal buftype= bufhidden=hide nobuflisted noswapfile
  setlocal nomodifiable
endfunction
