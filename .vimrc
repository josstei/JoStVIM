call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'josstei/vim-dogrun'
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

" **********************************************************
" ***************** NETRW SETUP ****************************
" **********************************************************
" - REMOVE BANNER 
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
colorscheme dogrun
" - SET COLORSCHEME 
" **********************************************************
" ***************** FZF CONFIG *****************************
" **********************************************************
" - SET FZF BUFFER OPEN AT BOTTOM 
let g:fzf_layout = {'down':'30%'}
autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 noshowmode noruler
	\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" - PREVENT FZF FROM OVERRIDING SPECIFIC BUFFER TYPES
function! FZFOpen(cmd)
    let functional_buf_types = ['quickfix', 'help', 'nofile', 'terminal', 'NERD_tree']
    if winnr('$') > 1 && (index(functional_buf_types, &bt) >= 0 || bufname('%') =~ 'NERD_tree_\d\+')
        let norm_wins = filter(range(1, winnr('$')),
                    \ 'index(functional_buf_types, getbufvar(winbufnr(v:val), "&bt")) == -1 && bufname(winbufnr(v:val)) !~ "NERD_tree"')
        let norm_win = !empty(norm_wins) ? norm_wins[0] : 0

        if norm_win > 0
            exe norm_win . 'winc w'
        endif
    endif

    exe a:cmd
endfunction

" ****** LEADER REMAPPING ******
nnoremap <space> <nop>
let mapleader = " " 

" **********************************************************
" ***************** NERD TREE SETUP ************************
" **********************************************************

" - OPEN AND FOCUS TO BUFFER 
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in")
  \ |   wincmd p
  \ | else
  \ |   wincmd p
  \ |   call ShowDefault()
  \ | endif
" - PREVENT NERDTree FROM BEING OVERRIDDEN BY OTHER BUFFERS
autocmd BufEnter * 
  \ if bufname('%') =~ 'NERD_tree_\d\+' && winnr('$') > 1
  \ |   let g:nerdTreeWin = winnr() 
  \ |   let g:nerdTreeBuf = bufnr('%')
  \ | elseif exists('g:nerdTreeWin') && winnr() == g:nerdTreeWin && bufname('%') !~ 'NERD_tree_\d\+'
  \ |   execute 'buffer ' . g:nerdTreeBuf
  \ | endif
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
        \ "🧭 WINDOW NAVIGATION",
        \ "   ▶ Press <Space> e → Toggle file explorer hide/show",
        \ "   ▶ Hold <Ctrl> and press one of the following keys:",
        \ "     - <C-h> → Move to the left buffer",
        \ "     - <C-j> → Move to the below buffer",
        \ "     - <C-k> → Move to the above buffer",
        \ "     - <C-l> → Move to the right buffer",
        \ "",
        \ "📂 SEARCHING FILES IN PROJECT",
        \ "   ▶ Press <Space> pf → Search for a file in the working directory.",
        \ "   ▶ Press <Space> pg → Search for a file tracked by Git.",
        \ "",
        \ "🖊 BUFFER EDITING",
        \ "   ▶ Press <Space> fs   → Save current buffer.",
        \ "   ▶ Press <Space> fq   → Close current buffer.",
        \ "   ▶ Press <Space> bye → Force Close current buffer.",
        \ "   ▶ Press <Space> bye → Close all buffers and exit JoStVim.",
        \ "",
        \ "══════════════════════════════════════════════════════════════════════════════════════════════"
        \ ]
  
  call setline(1, l:default)
  setlocal buftype=nofile bufhidden=hide nobuflisted noswapfile
  setlocal nomodifiable
endfunction
