"set nocompatible
set backspace=indent,eol,start
set mouse=a
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
syntax on
set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <C-j> :join<CR>
"nnoremap <F2> :b <C-Z>
"Commented out since conflicts with camelcasemotion
"nnoremap , <C-^>
set hidden
set nobackup
set nowritebackup
set incsearch
"highlight search results
set hls
"hides search results when pressing esc
nnoremap <CR> :noh<return><CR>
" Buffer naviation
map <M-Left> :bprevious<CR>
map <M-Right> :bnext<CR>
" Undo in insert mode.
imap <c-z> <c-o>u
colo summerfruit256
set t_Co=256

"""" PLUGINS """""
call pathogen#infect() 
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup
" No expand tabs on makefiles
"autocmd FileType make set noexpandtab
filetype plugin on
set omnifunc=syntaxcomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
map <F3> :FufBuffer<CR>

set runtimepath^=~/.vim/bundle/ctrlp.vim

"powerline
set laststatus=2
"set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup

nnoremap <F5> :GundoToggle<CR>

"change the 'completeopt' option so that Vim's popup menu doesn't select the
"first completion item, but rather just inserts the longest common text of all
"matches; and the menu will come up even if there's only one match
set completeopt=longest,menuone
"the first will make <C-N> work the way it normally does; however, when the
"menu appears, the <Down> key will be simulated. What this accomplishes is it
"keeps a menu item always highlighted. This way you can keep typing characters
"to narrow the matches, and the nearest match will be selected so that you can
"hit Enter at any time to insert it. In the above mappings, the second one is
"a little more exotic: it simulates <C-X><C-O> to bring up the omni completion
"menu, then it simulates <C-N><C-P> to remove the longest common text, and
"finally it simulates <Down> again to keep a match highlighted.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
    \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

let g:lua_complete_omni = 1

"--------OTHERS---------
"Hell!
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
" These are useful for moving between long wrapped lines.
nnoremap k gk
nnoremap j gj
vmap <C-C> "y+
imap <D-v> ^O:set paste<Enter>^R+^O:set nopaste<Enter>

"Show line numbers
set nu


"Automatic nopaste toggle 
"(from https://coderwall.com/p/if9mda)
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


"\s to replace all occurrences of the word under the cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

"Converts any number of left-aligned n-whitespace sequences to tab sequences
:command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g


