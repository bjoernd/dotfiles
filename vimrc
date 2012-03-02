set nocompatible

" PathoGen to manage plugins in subdirectories
call pathogen#infect()

" enable syntax highlighting
syntax enable

" coding on a dark background
set background=dark

" enable line numbering
set number

" do not expand tabs to spaces
set noexpandtab

" make tabs and auto indent be 4 spaces
set shiftwidth=4
set ts=4

" C indentation
set cinoptions=>s,:s,=s,gs,hs,ps,t0,+s,c3,C1,(0,u0,,m1,j1,)20,*30
set cindent

" automatically indent like the last line
set autoindent

" no line wrap, when there is none
set nowrap

" highlight search results
set hlsearch

" incremental search
set incsearch

" status line always on
set laststatus=2

" visual bell, do not beep!
set visualbell

" path to search for files
set path+=/usr/local/include

" my status line
set stl=%F-%m-%r-%y-%l/%L\ \(%p\%%\)\ \ %c

" gui font
if has("gui_running")
	set guifont=Inconsolata\ 8
	set co=110
	set lines=80
	set background=light
	colorscheme solarized
else
	set background=dark
	colorscheme spiderhawk
endif

" make the right mouse button to bring up popups
set mousemodel=popup

" invoke LaTeX suite when opening a Tex file
filetype plugin on

" adjust grep so that latex suite can use it
set grepprg=grep\ -nH\ $*

" Tell Vim, that SConstruct and SConscript files
" should be highlighted as Python  files
autocmd BufRead,BufNew SConstruct  set filetype=python
autocmd BufRead,BufNew SConscript  set filetype=python
autocmd BufRead,BufNew *.g         set expandtab nocindent filetype=antlr3 syntax=antlr3
autocmd BufRead,BufNew *.ypp       set filetype=yacc
autocmd BufRead,BufNew *.txt       set spell spelllang=en_us expandtab nocindent textwidth=78 wm=1
autocmd BufRead,BufNew TODO,README set spell spelllang=en_us expandtab nocindent textwidth=78 wm=1
autocmd BufRead,BufNew *.html      set textwidth=0 wm=0
autocmd BufRead,BufNew *.php       set textwidth=0 wm=0
autocmd BufRead,BufNew *.xml       set textwidth=0 wm=0
autocmd BufRead,BufNew *.go        set filetype=go
autocmd BufRead,BufNew *.simics    set filetype=simics
autocmd FileType mail              set textwidth=75 wm=1
autocmd FileType haskell           set expandtab nocindent
autocmd FileType c,cpp             set noexpandtab cindent
autocmd FileType python            set ai nocindent expandtab smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType help              set nospell
autocmd FileType tex               set nospell nocindent expandtab wm=1 tw=78

" key mappings
" <F1> is VIM's help
" <F3> is mapped by the spacehi plugin
nnoremap <silent> <C-F5> :TlistToggle<CR><ESC>
" <F6> to toggle highlighting of search results"
nnoremap <silent> <C-F6> :noh<CR><ESC>
" <F7> toggles spell checks
nnoremap <silent> <F7> :set spell!<CR><ESC>

" man page viewing
runtime ftplugin/man.vim
nnoremap <silent> <F8> :Man <C-R><C-W><CR>
nnoremap <silent> <C-F8> :Man 2 <C-R><C-W><CR>
nnoremap <silent> <S-F8> :Man 3 <C-R><C-W><CR>

" Alt-Left and Alt-Right are mapped to move between open buffers
nnoremap <M-Right> :bn<CR><ESC>
nnoremap <M-Left> :bN<CR><ESC>

" Ctrl+Alt+M for plain 'make'
nnoremap <C-M-M> :make<CR><ESC>

" LaTeX binding: takes the current line (containing a \begin{foo}[args]
" statement) and creates the corresponding \end{foo} statement underneath
inoremap <C-M-P> <ESC>yypwdwiend<ESC>%lD
nnoremap <C-M-P> <ESC>yypwdwiend<ESC>%lD

" Show all buffers and ask for the one to go to (found on the vim ML)
map __ :buffers<BAR>
           \let i = input("Buffer number: ")<BAR>
           \execute "buffer " . i<CR>

" Mapping and function to close vim, if the quickfix window is last
" XXX: handle tags explorer as well
au BufEnter * call MyLastWindow()
function! MyLastWindow()
  " if the window is quickfix go on
  if &buftype=="quickfix"
    " if this window is last on screen quit without warning
    if winbufnr(2) == -1
      quit!
    endif
  endif
endfunction

" ----- omnicomplete-c++ -----
" enable plugin loading
filetype plugin on
" Ctrl + F12 -> generate tags for current working directory
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" tag files ...
" ... generic C++ stl stuff generated from /usr/include/c++/4.4
"     (by replacing _GLIBCXX_NAMESPACE(.*) by 'namespace \1 {' etc)
set tags+=/home/doebel/.vim/tags/l4re.tags
"set tags+=/home/doebel/.vim/tags/llvm-2.6.tags
"set tags+=/home/doebel/.vim/tags/nova.tags
"set tags+=/home/doebel/.vim/tags/udis86.tags
"set tags+=/home/doebel/.vim/tags/cppunit.tags

" Run through buffer and remove trailing spaces
function! StripLines()
python << endpython
import vim
for i in range(len(vim.current.buffer)):
    vim.current.buffer[i] = vim.current.buffer[i].rstrip()
endpython
endfunction

let g:lisp_rainbow=1

" CommandT stuff
let g:CommandTMaxFiles = 100000
" default ignore rule
set wildignore+=*.o,*.a,.git,.svn
" ... and one that makes CommandT ignore unimportant l4re pkg directories
set wildignore+=boost*,linux-*-headers,Mesa

set foldmethod=indent
set foldnestmax=20
set nofoldenable
set foldlevel=2
set foldcolumn=2

au BufWinLeave ?* mkview
au BufWinEnter ?* loadview 

let g:clang_complete_copen=1
