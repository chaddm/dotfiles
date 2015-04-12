set nocompatible " Vundle required
filetype off " Vundle required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'
Plugin 'spf13/vim-autoclose'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'Shougo/neocomplete.vim'
Plugin 'scrooloose/syntastic'
Plugin 'mhinz/vim-signify'
Plugin 'groenewege/vim-less'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-markdown'
Plugin 'digitaltoad/vim-jade.git'
Plugin 'tpope/vim-haml'
Plugin 'amirh/HTML-AutoCloseTag'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'edkolev/tmuxline.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

let mapleader=','

" Autoindent with two spaces, always expand tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

set cursorline " Highlight the current line
set number " Who doesn't want line numbers?
set backspace=indent,eol,start
set history=1000
highlight clear SignColumn " Don't highlight left columns
highlight clear LineNr

set showmatch " Highlight match braces
set incsearch " Search as you type
set ignorecase " Case insensitive search
set smartcase " ...except when we put a cap in there
set scrolloff=5 " Minimum lines above/below cursor
set nowrap " Don't wrap long lines

" Remove trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
  let _s=@/
  let l=line(".")
  let c=col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l,c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Integrate with the clipboard if we have one
if has ('clipboard')
  if has ('unnamedplus')
    set clipboard=unnamed,unnamedplus
  else
    set clipboard=unnamed
  endif
endif

" Solarized
syntax enable
set background=dark
colorscheme solarized
" Let us switch from Solarized light to dark and back.
map <Leader>l :set background=light<CR>
map <Leader>d :set background=dark<CR>

" Fugitive
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gp :Gpush<CR>

" Syntastic
let g:syntastic_mode_map = { 'mode': 'active',
                            \ 'active_filetypes': ['ruby', 'coffee', 'javascript', 'json'],
                            \ 'passive_filetypes': ['html', 'handlebars'] }

" CoffeeWatch
set suffixesadd+=.coffee
map <Leader>cw :CoffeeWatch<CR>
map <Leader>cr :CoffeeRun<CR>
let coffee_watch_vert=1

" NERDTree
map <Leader>e :NERDTreeFind<CR>
let NERDTreeShowBookmarks=1
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1

" Airline
set laststatus=2 " Make airline show up at start.
let g:airline_powerline_fonts=1
let g:airline_theme='solarized'
let g:airline#extensions#branch#enabled=1

" Tabular
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>

" ctrlp
let g:ctrlp_user_command=['.git/', 'cd %s && git ls-files --exclude-standard -co']
let g:ctrlp_extensions=['tag', 'buffertag', 'quickfix', 'line', 'changes']
let g:ctrlp_custom_ignore={
  \ 'dir': '(node_modules)|(\v[\/]\.(git|hg|svn)$)'
  \ }

" buffergator
let g:buffergator_sort_regime='mru'

" Neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" File layouts
set noswapfile
set backup
set undofile
set undolevels=1000
set undoreload=10000

function! InitializeDirectories()
  let parent = $HOME . '/.vim/'
  let dir_list = {
              \ 'backup': 'backupdir',
              \ 'views': 'viewdir',
              \ 'undo': 'undodir' }

  let common_dir = parent . '/'

  for [dirname, settingname] in items(dir_list)
    let directory = common_dir . dirname . '/'
    if exists("*mkdir")
      if !isdirectory(directory)
        call mkdir(directory)
      endif
    endif
    if !isdirectory(directory)
      echo "Warning: Unable to create backup directory: " . directory
      echo "Try: mkdir -p " . directory
    else
      let directory = substitute(directory, " ", "\\\\ ", "g")
      exec "set " . settingname . "=" . directory
    endif
  endfor
endfunction
call InitializeDirectories()
