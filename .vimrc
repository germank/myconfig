"
" ===== Display =====
"
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
else
    colorscheme desert
endif

"
" ===== Native Options =====
set number                     " set line numbers
set cursorline                 " highlight cursor line 
set hlsearch                   " highlight search
set incsearch                  " highlight search and move cursor as you type
set showmatch                  " jump quickly to matching parenthesis
set autoindent                 " copy indent from previous line
set shiftwidth=4               " number of spaces per indent
set expandtab                  " replace <Tab> by... 
set tabstop=4                  " ... four spaces
set ruler                      " show position at file
set nobackup                   " do not create backup files
set noswapfile                 " do not create swap files
set laststatus=2               " show status bar after ruler
set linebreak                  " break long lines at spaces
set breakindent                " indent broken lines equally
set showbreak=..               " signal indents with ..
set colorcolumn=80             " color column at 80
set hidden                     " allow switching from unsaved buffers
set clipboard=unnamed          " use system's clipboard
set rtp+=~/.fzf                " where is fzf?
set backspace=indent,eol,start " always allow backspace
set undofile                   " Save undos after file closes
set undodir=$HOME/.vim/undo    " where to save undo histories
set undolevels=1000            " How many undos
set undoreload=10000           " number of lines to save for undo
set mouse=a                    " allows mouse scrolling and pointing
set autowrite                  " save files when calling make
"
" ===== Plugins =====
"
call plug#begin()
" fzf fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" allows seamless navigation between vim windows and tmux panes
Plug 'christoomey/vim-tmux-navigator'
" highlight all matches in incremental search
Plug 'haya14busa/incsearch.vim'
" search and replace the word under the cursor
Plug 'wincent/scalpel'
" LaTeX plugin
Plug 'lervag/vimtex'
" CamelCase motion 
" Plug 'bkad/CamelCaseMotion'
" Julia support
Plug 'JuliaEditorSupport/julia-vim'
" Snippets engine.
Plug 'SirVer/ultisnips'
" Snippets
Plug 'honza/vim-snippets'
" Clojure REPL
Plug 'tpope/vim-fireplace', {'tag': 'v2.1'}
" Clojure lisp text objects
Plug 'guns/vim-sexp'
" Lein project management
Plug 'tpope/vim-salve'
" Sexp default mappings redefinition
Plug 'tpope/vim-sexp-mappings-for-regular-people'
" Useful macros for surrounding stuff with parentheses or similar
Plug 'tpope/vim-surround'
" Clojure auto-format
Plug 'venantius/vim-cljfmt'
" base 16
Plug 'chriskempson/base16-vim'
" Nord
Plug 'nordtheme/vim', {'branch': 'main'}
call plug#end()

" Don't cljfmt on save
let g:clj_fmt_autosave = 0
nnoremap <Leader>c :Cljfmt<CR>

"Apply after vimtex is loaded
syntax on

" config: snippets
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" config: incsearch.vim ===
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" automatically clear highlighting
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" config: scalpel ===
nmap <Leader>s <Plug>(Scalpel)

" config: CamelCaseMotion ===
" call camelcasemotion#CreateMotionMappings(',')

" ===== Hacks =====
"
" Seamless copy-paste integration
vmap <C-C> "y+
imap <D-v> ^O:set paste<Enter>^R+^O:set nopaste<Enter>

" Automatically set paste mode in Vim when pasting in insert mode 
" (https://coderwall.com/p/if9mda)
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" fuzzy file finder
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>m :Buffers<CR>
"nnoremap <Leader>l :Lines<CR>

" These are useful for moving between long wrapped lines.
nnoremap k gk
nnoremap j gj

" Delete a buffer without closing a window
nnoremap <Leader>d :bp\|bd #<CR>

"Close window
nnoremap <Leader>q :close<CR>

" Remap the switch to last used buffer key combination
nnoremap <Leader>, <C-^>
nnoremap <Leader>\ <C-^>

" spelling correction
set spell spelllang=en_gb
hi SpellBad cterm=underline

" pydata coloring (TODO: put in a better place)
au BufNewFile,BufRead *.lmx set filetype=xml
