set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/Cellar/fzf/HEAD-202872c
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'suan/vim-instant-markdown'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'nvie/vim-flake8'
Plugin 'w0rp/ale'
Plugin 'mileszs/ack.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'elixir-editors/vim-elixir'
Plugin 'junegunn/fzf.vim'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'docunext/closetag.vim'

"Use ag instead of ack
let g:ackprg = 'ag --vimgrep --smart-case'                                                   
cnoreabbrev ag Ack                                                                           
cnoreabbrev aG Ack                                                                           
cnoreabbrev Ag Ack                                                                           
cnoreabbrev AG Ack  

"allow ale conflicts
let g:ale_emit_conflict_warnings = 0

call vundle#end()

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard', '*.swp', '*.swo']
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
filetype plugin indent on
filetype plugin on

set tabstop=2
set shiftwidth=2    
set expandtab 
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set so=2
colorscheme Monokai
syntax on
set backspace=indent,eol,start
set completeopt-=preview
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
set showcmd
set wildmenu
set laststatus=2
set statusline=%f "tail of the filename

map <Leader><Leader>/ :%!prettier --print-width 100 --no-bracket-spacing --single-quote --write % && ./node_modules/.bin/eslint --fix %<CR>:edit! %<CR>

"runs flake8 python check every time writes on a python file
autocmd BufWritePost *.py call Flake8()

"golang linter and automatic check on save
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow

" ALE config
" After this is configured, :ALEFix will try and fix your JS code with ESLint.
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

" use , as leader instead of \
let mapleader = ","

" toggle number on lines
nmap <Leader>l :setlocal number!<CR>

" highlight searchs
set incsearch

" case insensitive on searchs
set ignorecase

" case insensitive on search unless you include upper-case characters
set smartcase

" NERDTree toggle
nmap <Leader>e :NERDTreeToggle<CR>

" Enable code folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Map fzf commands to ; and ,t
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <C-P> :Files<CR>

" Map :Ack to ,a for search on project
nmap <Leader>a :Ack 
" Map ]q for next result on Ack and [q for previous result on Ack
nmap ]q :cnext<CR>
nmap [q :cprev<CR>
" Map to close QuickFix (search) window 
nmap <Leader>x :cclose<CR>

" Search on project the work on current cursor with command+k
nmap <C-k> :Ack! "\b<cword>\b" <CR>
