call plug#begin(expand('<sfile>:p:h') . '/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'psliwka/vim-smoothie'       
Plug 'preservim/nerdtree'
Plug 'josstei/vim-easydash'
Plug 'josstei/vim-easyline'
Plug 'josstei/vim-easyops'
Plug 'josstei/vim-easyenv'
Plug 'josstei/vim-tidyterm'
Plug 'josstei/vim-backtrack'
" ***** THEMES (Vim-Compatible) *****
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'morhetz/gruvbox'
    Plug 'arcticicestudio/nord-vim'
    Plug 'altercation/vim-colors-solarized'
    Plug 'crusoexia/vim-monokai'
    Plug 'sainnhe/everforest'
    Plug 'sainnhe/sonokai'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'joshdick/onedark.vim'
    Plug 'tomasr/molokai'
    Plug 'mhartington/oceanic-next'

" ***** THEMES (Neovim-only) *****
if has('nvim')
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    Plug 'folke/tokyonight.nvim'
    Plug 'rebelot/kanagawa.nvim'
    Plug 'navarasu/onedark.nvim'
    Plug 'EdenEast/nightfox.nvim'
    Plug 'rose-pine/neovim'
    Plug 'tanvirtin/monokai.nvim'
    Plug 'nyoom-engineering/oxocarbon.nvim'
    Plug 'sainnhe/edge'
    Plug 'marko-cerovac/material.nvim'
endif
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
	set fillchars=eob:\                             " - Hide characters at the end of the buffer
    filetype plugin indent on

    try
	if has('nvim') | colorscheme edge | else | colorscheme dracula | endif
    catch /.*/
        echom 'Jostvim: ' . v:exception
    endtry

    nnoremap <space> <nop>
    let mapleader = " "    " - Remap leader to space 
    inoremap jk <ESC> 

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
    tnoremap <c-n> <c-\><c-n>

" **********************************************************
" ***************** FILE SETUP *****************************
" **********************************************************
    nnoremap <leader>fq :q<CR>
    nnoremap <leader>fs :w<CR>
    nnoremap <leader>FQ :q!<CR>
    nnoremap <leader>bye :qa!<CR>

" **********************************************************
" ***************** WINDOW NAV START ***********************
" **********************************************************
	nnoremap <leader>wv :rightbelow vs new<CR>
	nnoremap <leader>wh :rightbelow split new<CR>
	nnoremap <leader>1 :1wincmd w<CR>
	nnoremap <leader>2 :2wincmd w<CR>
	nnoremap <leader>3 :3wincmd w<CR>
	nnoremap <leader>4 :4wincmd w<CR>
	nnoremap <leader>5 :5wincmd w<CR>
	nnoremap <leader>6 :6wincmd w<CR>

" **********************************************************
" ***************** FILE / TEXT SEARCH START ***************
" **********************************************************
	nnoremap <leader><leader> :call FZFOpen(':Files')<CR>
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

" **********************************************************
" ***************** COMMENT SETUP **************************
" **********************************************************
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

function! GetComment()
  return get(g:comment_map, &filetype, '# ')
endfunction

noremap <leader>cc :<C-B>silent s/^/<C-R>=escape(GetComment(), '/')<CR>/<CR> :nohlsearch<CR>
noremap <leader>cu :<C-B>silent s/^\V<C-R>=escape(GetComment(), '/')<CR>//e<CR> :nohlsearch<CR>
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

" **********************************************************
" ********************** EASYOPS ***************************
" **********************************************************
    let g:easyops_commands_main = [
        \ { 'label' : 'Git',    'command' : 'menu:git'    },
        \ { 'label' : 'Window', 'command' : 'menu:window' },
        \ { 'label' : 'File',   'command' : 'menu:file'   },
        \ { 'label' : 'Code',   'command' : 'menu:code'   },
        \ { 'label' : 'Misc',   'command' : 'menu:misc'  }
        \ ]
    let g:easyops_commands_code = [
        \ { 'label' : 'Maven',  'command' : 'menu:springboot|maven' },
        \ { 'label' : 'Vim',    'command' : 'menu:vim' }
        \ ]

    let g:easyops_commands_misc= [
        \ { 'label' : 'Create EasyEnv',  'command':':EasyEnvCreate' },
        \ ]
    let g:easyops_menu_misc = { 'commands' : g:easyops_commands_misc }

    nnoremap <silent> <leader>m :EasyOps<CR>
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
        autocmd TabNew * NERDTree | wincmd p
    augroup END

    nnoremap <leader>e :NERDTreeToggle<CR>

" **********************************************************
" ***************** EASYDASH SETUP *************************
" **********************************************************
    let g:easydash_menu_fzf         = { "keymap":"s", "label":"Search Project", "command":":Files<CR>" }
    let g:easydash_menu_backtrack   = { "keymap":"r", "label":"Recent Files",   "command":":Backtrack<CR>" }
    let g:easydash_menu_newfile     = { "keymap":"n", "label":"New File",       "command":":enew<CR>" }
    let g:easydash_menu_closejost   = { "keymap":"q", "label":"Quit",           "command":":qa!<CR>" }
    let g:easydash_options          = ['newfile','backtrack','fzf','closejost']
    let g:easydash_extras           = [strftime('%c'),'']
    let g:easydash_name             = 'Jostvim'
    let g:easydash_logo             = [
        \ '',
        \ '     ██╗ ██████╗ ███████╗████████╗██╗   ██╗██╗███╗   ███╗',
        \ '     ██║██╔═══██╗██╔════╝╚══██╔══╝██║   ██║██║████╗ ████║',
        \ '     ██║██║   ██║███████╗   ██║   ██║   ██║██║██╔████╔██║',
        \ '██   ██║██║   ██║╚════██║   ██║   ██║   ██║██║██║╚██╔╝██║',
        \ '╚█████╔╝╚██████╔╝███████║   ██║   ╚██████╔╝██║██║ ╚═╝ ██║',
        \ ' ╚════╝  ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝ ╚═╝╚═╝     ╚═╝',
        \ ''
        \ ]

" **********************************************************
" ***************** BACKTRACK SETUP ************************
" **********************************************************
    let g:backtrack_split                   = 'botright vsplit'
    let g:backtrack_max_count               = 10
    let g:backtrack_alternate_split_types   = ['easydash']
    let g:backtrack_alternate_split         = ''

" **********************************************************
" ***************** EASYLINE SETUP *************************
" **********************************************************
    let g:easyline_left_active_items    = ['windownumber','filename','modified']
    let g:easyline_left_inactive_items  = ['windownumber']
    let g:easyline_right_active_items   = ['position','filetype','encoding']
    let g:easyline_right_inactive_items = ['filename']
