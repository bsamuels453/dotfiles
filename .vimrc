set nocompatible 

"""""""dirty hacks"""""""

"color-coded cursor depending on mode; green for insert, red for command
if &term =~ "xterm\\|rxvt"
  let &t_SI = "\<Esc>]12;green\x7"
  let &t_EI = "\<Esc>]12;red\x7"
  silent !echo -ne "\033]12;red\007"
  autocmd VimLeave * silent !echo -ne "\033]112\007"
endif

" fix broken arrow key nav in insert mode
imap <ESC>oA <ESC>ki
imap <ESC>oB <ESC>ji
imap <ESC>oC <ESC>li
imap <ESC>oD <ESC>hi

" fix 1 second screen delay on switching out of insert to command mode
imap ` <C-c>`^

" forces the cursor's color to change when the mode changes to insert
" normally, the mode would change to insert and the cursor color would not change until you started typing
nmap i id<BS>


"""""""general settings"""""""

let &t_Co=256				" let vim know we got all dem 256 colors
filetype plugin indent on  		" Automatically detect file types.
syntax on 				" syntax highlighting
colorscheme molokai
set mouse=a				" automatically enable mouse usage
set history=1000  			" Store a ton of history (default is 20)
set undofile				" so is persistent undo ...
set undolevels=1000 			" maximum number of changes that can be undone
set undoreload=10000 			" maximum number lines to save for undo on a buffer reload
set tabpagemax=15 			" only show 15 tabs
set showmode                   		" display the current mode
set ruler                  		" show the ruler
set rulerformat=%l,%c 			" simple ruler with line/char numbers
set showcmd                		" show partial commands in status line
set backspace=indent,eol,start		" backspace for dummys
set linespace=0				" No extra spaces between rows
set nu					" Line numbers on
set incsearch				" find as you type search
set hlsearch				" highlight search terms
set ignorecase				" case insensitive search
set smartindent				" sane auto indenting
set shiftwidth=4			" set up indent width
set tabstop=4				"
set wildmenu				" show list instead of just completing
set wildmode=list:longest,full		" command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]		" backspace and cursor keys wrap to
set scrolljump=5 			" lines to scroll when cursor leaves screen
set scrolloff=3 			" minimum lines to keep above and below cursor
" set foldenable  			" auto fold code
set gdefault				" the /g flag on :s substitutions by default
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.   " Highlight problematic whitespace	
set nowrap                     			" wrap long lines
set relativenumber                              " makes jumping easier
set nohlsearch				" no highlighting search queries
"  Remove trailing whitespaces and ^M chars
" autocmd FileType c, hs,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"""""""binds & dirty hacks"""""""

" screw the shift button, dont wanna waste time with that crap
nnoremap ; :

" fix shift key abomination 
cmap W w
cmap Q q

" sane pasting 
map <C-v> "+p
imap <C-v> <C-c>"+pi
map <C-c> "+y
" sane undo
map <C-z> u
imap <C-z> <C-c>u


"""""""file type mappings"""""""

" set up rust syntax coloring
au BufRead,BufNewFile *.rs,*.rc set filetype=rust

" set up logfile syntax coloring using the syslogd coloring scheme
au BufRead,BufNewFile *.log set filetype=messages


"""""""compiler mappings"""""""

" Map F5 to load the current file into ghci; shamelessly stolen from kuraitou
if has("unix")
	autocmd FileType haskell nmap <buffer> <F5> :!ghci %:p<CR>
	autocmd FileType haskell nmap <buffer> <F6> :!ghc %:p<CR>
	autocmd FileType haskell nmap <buffer> <F7> :!./%:r<CR>
	"haskell indenting stuff
	autocmd FileType haskell set tabstop=8
	autocmd FileType haskell set expandtab
	autocmd FileType haskell set softtabstop=4
	autocmd FileType haskell set shiftwidth=4
	autocmd FileType haskell set smarttab
	autocmd FileType haskell set shiftround
	autocmd FileType haskell set nojoinspaces
endif

" Map F5 to load current file into node
if has("unix")
	autocmd FileType javascript nmap <buffer> <F5> :!node %:p<CR>
endif


" Map F5 for launching python files
if has("unix")
	autocmd FileType python nmap <buffer> <F5> :!python %:p<CR>
endif

" Map F5 for launching make
if has("unix")
	autocmd FileType c nmap <buffer> <F5> :!make %:r<CR>
endif

" Map F5 for launching rustc
if has("unix")
	autocmd FileType rust nmap <buffer> <F5> :!rustc %:p -Z debug-info<CR>
endif

" Map F6 to gdb
if has("unix")
	nmap <buffer> <F6> :!gdb %:r<CR>
endif

"""""""other stuff"""""""

autocmd FileType python compiler pylint

" switch line numbering depending on current mode
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

