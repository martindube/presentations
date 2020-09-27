" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"filetype plugin indent on
"endif

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

""""""""""""""""""""""""""""""""""""""""""""""""""
" DISPLAY OF THE EDITOR
set virtualedit=all
set number
"set list
set listchars=tab:>=,eol:$,trail:-
set t_Co=256        " Set the terminal to 256 colors
"set showmatch
"set matchtime=1
set incsearch
set history=100
set nowrap
"set whichwrap=<,>,h,l
set wildmode=list:longest "full
set wildmenu
"set foldlevelstart=99

colors slate


""""""""""""""""""""""""""""""""""""""""""""""""""
" DISPLAY IF LENGTH >80
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.*/


""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUSBAR
set laststatus=2
set statusline=%f%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]%=[POS=%04l,%04v][%p%%]\ [LEN=%L]
" COLORS
hi Statusline ctermfg=2* ctermbg=0
au InsertEnter * hi StatusLine ctermfg=1 ctermbg=7
au InsertLeave * hi StatusLine ctermfg=2 ctermbg=7 gui=bold,reverse
set updatetime=50


""""""""""""""""""""""""""""""""""""""""""""""""""
" CONFIGURATION FOR INDENTATION
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set cindent
set shiftround


