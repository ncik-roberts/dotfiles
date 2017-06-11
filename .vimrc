"""""""""""""""""""""""""""""""""""""""""""""""
" Mappings and remappings
"""""""""""""""""""""""""""""""""""""""""""""""

" Make it so j and k move wrt to virtual lines
" as well as that we can jump using relative numbers using <number>j and
" <number> k.
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
map <space> <leader>
nnoremap <leader> viw

" Uppercase current word
inoremap <c-u> <esc>gUiwea

" Edit and source .vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Surround current word or Word with quotation marks
nnoremap <leader>"         viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>'         viw<esc>a'<esc>hbi'<esc>cu
nnoremap <leader><leader>" viW<esc>a"<esc>hbi"<esc>lel
nnoremap <leader><leader>' viW<esc>a'<esc>hbi'<esc>cu

" Indent line to the right
nnoremap <leader>> i<tab><esc>
nnoremap <leader>j i<cr><esc>

" Move to the end or beginning of line
nnoremap <leader>l $
nnoremap <leader>h 0

" Map jk to <esc> in insert mode and <esc> to nothing in both modes
" Use V as <esc> in visual mode
inoremap jk <esc>
vnoremap <esc> <nop>
inoremap <esc> <nop>

" Use CTRL+H to get help for current token
nnoremap  :help<space><cr>

" Yank to end of line
nnoremap Y y$

"""""""""""""""""""""""""""""""""""""""""""""""""
" Set colorscheme and syntax highlighting
"""""""""""""""""""""""""""""""""""""""""""""""""

" Enable filetype detection and syntax highlighting
filetype plugin indent on
syntax on

" Only show what we can
set t_Co=256

" Highlight in visual mode
highlight Visual cterm=reverse ctermbg=NONE

" Syntax highlighting for different kinds of files
au BufRead,BufNewFile *.c1 setlocal filetype=c0
au BufRead,BufNewFile *.sig setlocal filetype=sml
au BufRead,BufNewFile *.html setlocal nowrap

"""""""""""""""""""""""""""""""""""""""""""""""""
" Set the flags and options that I like :)
"""""""""""""""""""""""""""""""""""""""""""""""""

" Show multicharacter commands as they are being typed
set autoindent  " autoindent on new lines
set backspace=indent,eol,start " Better backspacing
set conceallevel=2 " Do nice syntax hiding in LaTeX
set encoding=utf-8 " UTF-8 character encoding
set equalalways  " Split windows equal size
set expandtab  " Expand tabs into spaces
set formatoptions=croq  " Enable comment line auto formatting
set hlsearch  " Highlight on search
set incsearch  " Start searching immediately
set lazyredraw  " Don't redraw while running macros (faster)
set linebreak  " Intelligently wrap long files
set nocompatible  " Kill vi-compatibility
set nostartofline " Vertical movement preserves horizontal position
set number " Show line number on current line
set relativenumber " On all lines except for current line, show how far away
set ruler  " Show bottom ruler
set scrolloff=5  " Never scroll off
set showcmd " Show keystrokes as you press them
set showmatch  " Highlight matching braces
set softtabstop=2  "Tab spaces in no hard tab mode
set smartindent
set sw=2 " Tabs should be 2
set title  " Set window title to file
set ttyfast  " Speed up vim
set wildignore+=*.o,*.obj,*.class,*.swp,*.pyc " Ignore junk files
set wildmode=longest,list  " Better unix-like tab completion
set wrap  " Visually wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatic commands when writing or opening file
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Strip whitespace from end of lines when writing file
autocmd BufWritePre * :%s/\s\+$//e
" Auto-indent files
autocmd BufWritePre *.html :normal gg=G

" Auto-comment-out lines

" // for single lines, /* */ for multiple lines
function! FtpluginSlashComment()
  nnoremap <buffer> <localleader>c I//<esc>
  nnoremap <buffer> <localleader>d ^xx<esc>
  vnoremap <buffer> <localleader>c <esc>`<I/*<esc>`>A*/<esc>
  vnoremap <buffer> <localleader>d <esc>`<^xx<esc>`>$xx<esc>
endfunction

autocmd Filetype javascript,java,c call FtpluginSlashComment()

" Add character + space to beginning of lines
function! FtpluginLeadingCharacter(leading)
  execute "nnoremap <buffer> <localleader>c I" . a:leading . "<space><esc>"
  nnoremap <buffer> <localleader>d ^2x<esc>
  execute "vnoremap <buffer> <localleader>c :normal I" . a:leading . "<space><esc>"
  vnoremap <buffer> <localleader>d :normal ^2x<esc>
endfunction

autocmd Filetype python,perl,sh call FtpluginLeadingCharacter("#")
autocmd Filetype vim call FtpluginLeadingCharacter("\"")

" Wrap given lines in (*)
function! FtpluginSML()
  nnoremap <buffer> <localleader>c I(*<esc>A*)<esc>
  nnoremap <buffer> <localleader>d ^xx$xx<esc>
  vnoremap <buffer> <localleader>c <esc>`<I(*<esc>`>A*)<esc>
  vnoremap <buffer> <localleader>d <esc>`<^xx<esc>`>$xx<esc>
endfunction

autocmd Filetype sml,ocaml call FtpluginSML()

" Add special HTML shortcuts
function! FtpluginHTML()
  iabbrev <buffer> `` &ldquo;
  iabbrev <buffer> '' &rdquo;
endfunction

autocmd Filetype html call FtpluginHTML()

""""""""""""""""""""""""""""""""""
" Set up external plugins
""""""""""""""""""""""""""""""""""

execute pathogen#infect()

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

augroup mySyntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
augroup END

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor

" Syntastic error window will show Merlin errors
let g:syntastic_ocaml_checkers = ['merlin']

" <leader>a to autocomplete
inoremap /. 

" ## end of OPAM user-setup addition for vim / base ## keep this line
