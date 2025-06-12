call plug#begin()
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'psliwka/vim-smoothie'       
Plug 'preservim/nerdtree'
Plug 'josstei/vim-jostline'
Plug 'josstei/vim-easyops'
Plug 'josstei/vim-easyenv'
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

    " - Allow system clipboard if applicable
    if has('clipboard')     | set clipboard+=unnamedplus    | endif
    " - Enables 24-bit RGB (true color) support in the terminal ic applicable
	if has("termguicolors") | set termguicolors             | endif

	set nocompatible                                " - Enables full Vim features (modern mode)
	set relativenumber                              " - Display line numbers relative to current line
    set number
	set ignorecase                                  " - remove case sensitivity for search
	set cursorline                                  " - Highlight line cursor is currently on
	set timeoutlen=500                              " - Timeout length between keymap keystrokes (in ms)
	set encoding=UTF-8                              " - Set encoding to UTF-8
    set tabstop=4 shiftwidth=4 expandtab
    set autoindent
    set smartindent
	set noswapfile                                  " - Prevent swap file creation
	syntax on                                       " - Enable syntax highlighting
	colorscheme dracula                             " - Set colorscheme
	set fillchars=eob:\                             " - Hide characters at the end of the buffer
    filetype plugin indent on

    nnoremap <space> <nop>
    let mapleader = " "    " - Remap leader to space 

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

" **********************************************************
" ***************** TERMINAL SETUP *************************
" **********************************************************
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
        if empty(l:searchText)
            echo "Cancelled."
            return
        endif

        if has('win32') || has('win64')
            let l:cmd = 'findstr /S /N /I /P /C:' . shellescape(l:searchText) . ' *'
        else
            let l:cmd = 'grep -rniI --exclude-dir=.git ' . shellescape(l:searchText) . ' .'
        endif

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

" ********** JAVA SETUP START **********
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

" **********************************************************
" ********************* JOSTLINE ***************************
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
" ********************** EASYOPS ***************************
" **********************************************************
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

" **********************************************************
" ********************* TIDYTERM ***************************
" **********************************************************
    nnoremap <silent> <C-_> :TidyTerm<CR>
    tnoremap <silent> <C-_> <C-\><C-n>:TidyTerm<CR>

" **********************************************************
" ************************ FZF *****************************
" **********************************************************
	let g:fzf_layout = {'down':'20%'}
    augroup jost_fzf
        autocmd!
        autocmd FileType fzf
            \ set laststatus=0 noshowmode noruler |
            \ autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    augroup END

    function! FZFOpen(cmd)
        call NavigateToOpenWindow()
        execute a:cmd
    endfunction

" **********************************************************
" ***************** NERD TREE SETUP ************************
" **********************************************************
let NERDTreeMinimalUI = 1

augroup NerdTreeHandler
    autocmd!
    autocmd TabNew,VimEnter * NERDTree | wincmd p 
augroup END

nnoremap <leader>e :NERDTreeToggle<CR>

" move this out into the dashboard.vim
augroup DashboardAutoCenter
    autocmd!
    autocmd VimResized,WinEnter,BufWinEnter * call DashboardResize()
augroup END

function! DashboardResize() abort
    for winnr in range(1, winnr('$'))
        let bufnr = winbufnr(winnr)
        if getbufvar(bufnr, '&filetype') ==# 'dashboard'
            let curwin = winnr()
            execute winnr . 'wincmd w'
            call dashboard#Draw()
            execute curwin . 'wincmd w'
        endif
    endfor
endfunction
