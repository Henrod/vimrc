set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'kien/ctrlp.vim'
Plugin 'elzr/vim-json'
Plugin 'suan/vim-instant-markdown'
Plugin 'godlygeek/tabular'
Plugin 'evanmiller/nginx-vim-syntax'
Plugin 'Shougo/neocomplete.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
Plugin 'nvie/vim-flake8'
Plugin 'davidhalter/jedi-vim'

Plugin 'scrooloose/syntastic'
"let g:syntastic_check_on_open=1

Plugin 'marijnh/tern_for_vim'

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
"
"    set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0


inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

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
