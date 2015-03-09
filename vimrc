set nocompatible

" PathoGen to manage plugins in subdirectories -> should be the first thing
" after 'set nocomp'
call pathogen#infect()

set rtp+=~/.vim/bundle/vundle
set rtp+=~/src/powerline/powerline/bindings/vim
call vundle#rc()

Bundle "gmarik/vundle"
"Bundle "Valloric/YouCompleteMe"

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" enable syntax highlighting
syntax enable

" coding on a dark background
set background=dark

" enable line numbering
set number

" do not expand tabs to spaces
set noexpandtab

set backspace=2

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

" Power Line config
set encoding=utf-8
set t_Co=256
let g:Powerline_stl_path_style="relative"


" Syntastic config
"let g:syntastic_auto_loc_list=1
"let g:syntastic_enable_signs=1
"let g:syntastic_check_on_open=1
"let g:syntastic_cpp_config_file="/home/doebel/src/tudos/l4/pkg/syntastic.conf"
"let g:syntastic_c_config_file="/home/doebel/src/tudos/l4/pkg/syntastic.conf"
"let g:syntastic_cpp_check_header = 1


" YouCompleteMe config
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']
let g:ycm_confirm_extra_conf = 0
let g:ycm_add_preview_to_competeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_server_use_vim_stdout=0


" UtilSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"


" visual bell, do not beep!
set visualbell

" path to search for files
set path+=/usr/local/include

" my status line
set stl=%F-%m-%r-%y-%l/%L\ \(%p\%%\)\ \ %c

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

" close NERDTree if it is the last window
autocmd bufenter *                 if(winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTree == "primary") | q | endif

" key mappings
" <F1> is VIM's help
" <F3> is mapped by the spacehi plugin
nnoremap <silent> <F4> :TlistToggle<CR><ESC>
" <F6> to toggle highlighting of search results"
nnoremap <silent> <F6> :noh<CR><ESC>
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

" Ctrl + up/down to navigate through quickfix buffer entries
nnoremap <C-Up> :cp<CR><ESC>
nnoremap <C-Down> :cn<CR><ESC>

" Ctrl+Alt+M for plain 'make'
nnoremap <C-M-M> :!make<CR><ESC>

" Ctrl+Alt+U -> ensure BibTex words to be uppercase and wrapped with braces
nnoremap <C-M-U> vUi{<ESC>lli}<ESC>ww

" LaTeX binding: takes the current line (containing a \begin{foo}[args]
" statement) and creates the corresponding \end{foo} statement underneath
inoremap <C-M-P> <ESC>yypwdwiend<ESC>%lD
nnoremap <C-M-P> <ESC>yypwdwiend<ESC>%lD

nnoremap <M-f> :NERDTreeToggle<CR>

noremap <C-M-S> :ScratchOpen<CR>
noremap <C-M-E> :ScratchEval<CR>

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

" Using vim as a hex editor
" http://vim.wikia.com/wiki/Improved_hex_editing

" Ctrl+H x
nnoremap <C-H>x :Hexmode<CR>

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" autocmds to automatically enter hex mode and handle file writes properly
if has("autocmd")
  " vim -b : edit binary using xxd-format!
  augroup Binary
    au!

    " set binary option for all binary files before reading them
    au BufReadPre *.bin,*.hex setlocal binary

    " if on a fresh read the buffer variable is already set, it's wrong
    au BufReadPost *
          \ if exists('b:editHex') && b:editHex |
          \   let b:editHex = 0 |
          \ endif

    " convert to hex on startup for binary files automatically
    au BufReadPost *
          \ if &binary | Hexmode | endif

    " When the text is freed, the next time the buffer is made active it will
    " re-read the text and thus not match the correct mode, we will need to
    " convert it again if the buffer is again loaded.
    au BufUnload *
          \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
          \   call setbufvar(expand("<afile>"), 'editHex', 0) |
          \ endif

    " before writing a file when editing in hex mode, convert back to non-hex
    au BufWritePre *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd -r" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif

    " after writing a binary file, if we're in hex mode, restore hex mode
    au BufWritePost *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd" |
          \  exe "set nomod" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif
  augroup END
endif

" ycm: add latex completion trigger
let g:ycm_semantic_triggers =  {
  \   'tex' : ['\ref{','\cite{', '\shortcite{'],
  \ }

" Generally, this file is the global one I keep in github. Local
" customizations go into a runtime file:
runtime vim.local

hi clear SpellBad
hi SpellBad guibg=DarkYellow guifg=DarkBlue
