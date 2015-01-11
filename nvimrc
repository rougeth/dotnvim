"
"        __      __  _   ___    ___
"   ____/ /___  / /_/ | / / |  / (_)___ ___
"  / __  / __ \/ __/  |/ /| | / / / __ `__ \
" / /_/ / /_/ / /_/ /|  / | |/ / / / / / / /
" \__,_/\____/\__/_/ |_/  |___/_/_/ /_/ /_/
"
" Author: Marco Rougeth <marco at rougeth dot com>
" Based on Vim *options.txt*
"
" 1 Important
" 1.5 Plugins
" 2 Moving around, searching and patterns
" 4 Displaying text
" 5 Syntax, highlighting and spelling
" 6 Multiple windows
" 11 Messages and info
" 13 Editing text
" 14 Tabs and indenting
" 18 Reading and writing filese
" 20 Command line editing
" 26 Keys mapping
" 27 Bonus
"


" 1 Important
" ===========
set nocompatible " disable Vi compatibility
set encoding=utf-8 " define encoding


" 1.1 NeoBundle Core (vim-bootstrap)
" ==================================
set runtimepath+=~/.nvim/bundle/neobundle.vim/
let neobundle_readme=expand('~/.nvim/bundle/neobundle.vim/README.md')

if !filereadable(neobundle_readme)
    echo "Installing NeoBundle..."
    echo ""
    silent !mkdir -p ~/.nvim/bundle
    silent !git clone https://github.com/Shougo/neobundle.vim ~/.nvim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.nvim/bundle/'))

" 1.2 Plugins
" ===========

NeoBundle 'godlygeek/csapprox'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'sheerun/vim-polyglot'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'scrooloose/syntastic'

" Python
NeoBundle 'davidhalter/jedi-vim'

" C
NeoBundle 'vim-scripts/c.vim'

" HTML
NeoBundle 'amirh/HTML-AutoCloseTag'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'gorodinskiy/vim-coloresque'
NeoBundle 'mattn/emmet-vim'

call neobundle#end()
filetype plugin indent on

NeoBundleCheck


" 2 Moving around, searching and patterns
" =======================================
set ignorecase " ignore case when using a search pattern
set smartcase " override 'ignorecase' when pattern has upper case characters


" 4 Displaying text
" ================
set scrolloff=10 " number of screen lines to show around the cursor
set number " show the line number for each line


" 5 Syntax, highlighting and spelling
" ===================================
set background=dark " the background color brightness
filetype plugin on " type of file; triggers the FileType event when set
filetype indent on
syntax on " enable syntax highlight
set hlsearch " highlight all matches for the last used search pattern
set t_Co=256 " enable 256 colors
set cursorline " highlight the screen line of the cursor
set colorcolumn=80 " columns to highlight
colorscheme base16-default


" 6 Multiple windows
" ==================
set splitbelow " open new split panes to right and bottom
set splitright


" 11 Messages and info
" ====================
set showcmd " show (partial) command keys in the status line
set ruler " show cursor position below each window
set noerrorbells " disable the bell for error messages
set novisualbell " disable the visual bell


" 13 Editing text
" ===============
set undolevels=1000 " maximum number of changes that can be undone
set backspace=indent,eol,start " specifies what <BS>, CTROL-W, etc. can do in
                               " Insert mode
set showmatch " when inserting a bracket, briefly jump to its match


" 14 Tabs and indenting
" =====================
set tabstop=4 " number of spaces a <Tab> in the text stands for
set shiftwidth=4 " number of spaces used for each step of (auto)indent
set smarttab " a <Tab> in an indent inserts 'shiftwidth' spaces
set expandtab " expand <Tab> to spaces in Insert mode
set autoindent " automatically set the indent of a new line
set smartindent " do clever autoindenting


" 18 Reading and writing filese
" =============================
set autoread " automatically read a file when it was modified outside Vim


" 20 Command line editing
" =======================
set history=100 " how many command lines are remembered
set wildignore=*.o,~*,*.pyc " list of patterns to ignore files for files name
                            " completion
set wildmenu " command line completion shows a list of matches


" 26 Keys mapping
" ===============
imap jj <ESC>
nnoremap j gj " improve up/down movement on wrapped lines (vimbits)
nnoremap k gk
noremap J L " jump to the top and bottom line using
noremap K H
noremap H ^ " jump to start and end of line using the home row keys
noremap L $
nnoremap <c-h> <c-w><c-h> " easier split navigations with Ctrl-(h,j,k,l)
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>


" 27 Bonus
" ========
" This beauty remembers where you were the last time ou edited the file, and
" returns to the same position. Seriouly, it's awesome.
au BufReadPost * if line("'\'") > 0|if line("'\'") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

autocmd BufWritePre * :%s/\s\+$//e " automatically remove all trailing whitespace

if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif
