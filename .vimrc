set viminfo='20,<1000

" Start with everything folded
set foldlevelstart=0

" set the leader key to be spacebar
let mapleader = "\<space>"

set incsearch

set hlsearch
noh

set autoindent

nnoremap <cr> :noh<cr><cr>

nnoremap ; :
vnoremap ; :

set nocp

filetype plugin on

let omnicpp_namespacesearch = 1      
let omnicpp_globalscopesearch = 1      
let omnicpp_showaccess = 1      
let omnicpp_maycompletedot = 1      
let omnicpp_maycompletearrow = 1      
let omnicpp_maycompletescope = 1      
let omnicpp_defaultnamespaces = ["std", "_glibcxx_std"]     

" you can set this (or other settings) to a toggle like so
noremap <f4> :set hlsearch! hlsearch?<cr>
"
" set locations of tags file
set tags=~/.vim/tags

" remap @q to close and compile
let @q=":wa:make"

set makeprg=ca
"set makeprg=./make_script

" needed to initialize pathogen
execute pathogen#infect()
execute pathogen#helptags()

" ignores doxygen files when using command-t
set wildignore=doxygen*,*/build/*

noremap <f5> :!gen_tags
"
" put vim_util.vim in your home directory
source ~/vim_util.vim
" remap @w to jump between source code and header
" and @e to split
let @w=":call HeaderJump()"
let @e=":call HeaderSplit()"

" macro for quickly switching to ~/.vimrc file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" macro to quickly source ~/.vimrc file so you don't need
" to restart vim after adding a macro (such as with <leader>ev macro)
nnoremap <leader>sv ma<cr>:silent! source $MYVIMRC<cr>'azz

" macro to surround any selected text with double quotes
" doesn't work with block selections (but why would you put
" quotes around a block anyways?)
vnoremap <leader>" di""<esc>p

" add {...} block around block of visually selected text
" only works in block mode
vnoremap <leader>{ c{<cr>}<esc>pkva{=
nnoremap <leader>{ cc{<cr>}<esc>pkva{=

" quick exit out of insert mode
inoremap jk <esc>

" Switch the value of these characters since the more useful one is harder
" to reach
nnoremap ` '
nnoremap ' `

" Re-enable <esc> instead of jk when jk must be used
"nnoremap <leader>k :iunmap <c-v><c-[><cr>:iunmap jk<cr>

nnoremap <leader>; mqA;<c-[>`q

" Vimscript file settings {{{
augroup filetype_vim
	autocmd!
;
	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType vim nnoremap <buffer> <leader>c I" <esc>
augroup END
" }}}

" C++ file settings {{{
augroup filetype_cpp
	autocmd!

	" Macros for comments
	autocmd FileType cpp vnoremap <buffer> <leader>c :s!\(^\s*\)!\1// !<cr>:noh<cr>
	" autocmd FileType cpp nnoremap <buffer> <leader>c I// <esc>
augroup END
" }}}

nnoremap <leader>c :clist<cr>

let g:sneak#s_next = 1


"This will match all forward slashes that are not comments:
"let @k='\(\(\/\|\*\)\@<!\/\(\/\|\*\)\@!\)'
"
"This will match - and > that aren't pointer derefernce:
"let @l='\(->\@!\|<\|-\@<!>\)'
"
"let @p='\(+\@<!++\@!\)'
"
"This will match all characters that should be spaced
"let @c='\(==\|!=\|+=\|-=\|*=\|>>\|<<\|>=\|<=\|=\|p\|*\|k\|l\)'
"
"let @g='gg=G'
"
"let @h='%s/\(\S\+\)\@<={/\r\0/eg'
"
"his matches all spaced characters that do not occur in an #include
"```
"let @s='\(\(#include.\+\)\@<!c\)'
"let @t='/p'
"let @a='%s/\w\@<=s/ \0/eg'
"let @b='%s/s\w\@=/\0 /eg'
"let @f=':a | b | h'
"
"let @q=":w
":! ca
":q
