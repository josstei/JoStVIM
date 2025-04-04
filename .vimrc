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
let g:functionalBuffers = ['quickfix', 'help', 'nofile', 'terminal']
let g:fzf_layout = {'down':'30%'}

autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 noshowmode noruler
	\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

function! FZFOpen(cmd)
	call NavigateToOpenWindow()
    exe a:cmd
endfunction

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
" - BUFFER DELETE
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bs :w<CR>

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
nnoremap <leader>pf :call FZFOpen(':Files')<CR>
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
  setlocal buftype= bufhidden=hide noswapfile
  setlocal nomodifiable
endfunction

" Airline {
" let g:airline_theme='papercolor'
" show git branch
" let g:airline#extensions#branch#enabled=1
" let g:airline#extensions#hunks#enabled=0
" let g:airline_powerline_fonts=1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t'
" }
