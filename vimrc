" the configuration are based on:
"   * https://github.com/skwp/dotfiles/blob/master/vimrc
"   * https://raw.github.com/kepbod/ivim/master/vimrc
"
set nocompatible    " turn off plain vi compatibility

" ================ General Config ====================

filetype plugin indent on       " Enable filetype

let mapleader=','               " Change the mapleader
let maplocalleader='\'          " Change the maplocalleader
set timeoutlen=500              " Time to wait for a command

" Source the vimrc file after saving it
autocmd BufWritePost .vimrc source $MYVIMRC
" Fast edit the .vimrc file using ',x'
nnoremap <Leader>x :tabedit $MYVIMRC<CR>

set autoread                    "Reload files changed outside vim
set autowrite                   " Write on make/shell commands
set clipboard+=unnamed          " Yanks go on clipboard instead
set spell                       " Spell checking on
set modeline                    " Turn on modeline
set encoding=utf-8              " Set utf-8 encoding
set completeopt+=longest        " Optimize auto complete
set completeopt-=preview        " Optimize auto complete
set mousehide                   " Hide mouse after chars typed
set mouse=a                     " Mouse in all modes

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom

set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on


" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundle.vim
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
endif

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype plugin on
filetype indent on

" ================ Searching ======================
set ignorecase " Case insensitive search
set smartcase " Case sensitive when uc present
set hlsearch " Highlight search terms
set incsearch " Find as you type search
set gdefault " turn on 'g' flag
"
" Use sane regexes
nnoremap / /\v
vnoremap / /\v
cnoremap s/ s/\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap s? s?\v

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g* g*zzzv
nnoremap g# g#zzzv

" Visual search mappings
function! s:VSetSearch()
    let temp=@@
    normal! gvy
    let @/='\V'.substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@=temp
endfunction
vnoremap * :<C-U>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-U>call <SID>VSetSearch()<CR>??<CR>

" Use ,Space to toggle the highlight search
nnoremap <Leader><Space> :set hlsearch!<CR>


" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

"

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Color scheme ========================
syntax enable
set background=dark
if !has('gui_running')
    set t_Co=256 " Use 256 colors
endif
colorscheme solarized

if has('gui_running')
    if has('gui_gtk')
        set guifont=DejaVu\ Sans\ Mono\ 12
    elseif has('gui_macvim')
        set guifont=Monaco:h12
    endif
endif

" Set title
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}

" ===================== Plugins ====================
" Plugin: hardmode
" * enable for default and set toogling
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>


" Plugin: Tagbar
nnoremap <Leader>t :TagbarToggle<CR>
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_foldlevel=2
let g:tagbar_ironchars=['▾', '▸']
let g:tagbar_autoshowtag=1

" Plugin: 
"
" ================= new, to check"

" syntastic config
let g:syntastic_python_checkers=['pylama']"

" neocompl config
"let g:neocomplcache_enable_at_startup=1
"let g:neocomplcache_enable_at_startup=1
"let g:neocomplcache_enable_auto_delimiter=1
"let g:neocomplcache_enable_camel_case_completion=1
"let g:neocomplcache_enable_underbar_completion=1

" Tell Neosnippet about the other snippets
"let g:neosnippet#snippets_directory="$HOME/.vim/bundle/vim-snippets/snippets"
"let g:neosnippet#enable_snipmate_compatibility=1

" Plugin key-mappings
"imap <C-K> <Plug>(neosnippet_expand_or_jump)
"smap <C-K> <Plug>(neosnippet_expand_or_jump)
"xmap <C-K> <Plug>(neosnippet_expand_target)
"
" Map <C-E> to cancel completion
"inoremap <expr><C-E> neocomplcache#cancel_popup()

" SuperTab like snippets behavior
"inoremap <expr><Tab> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-N>" : "\<Tab>"
"snoremap <expr><Tab> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
"inoremap <expr><S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"

" CR/S-CR: close popup and save indent
"inoremap <expr><CR> delimitMate#WithinEmptyPair() ? "\<C-R>=delimitMate#ExpandReturn()\<CR>" : pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"inoremap <expr><S-CR> pumvisible() ? neocomplcache#close_popup() "\<CR>" : "\<CR>"

" Use local vimrc if available
if filereadable(expand("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

" Use local gvimrc if available and gui is running
if has('gui_running')
    if filereadable(expand("$HOME/.gvimrc.local"))
        source $HOME/.gvimrc.local
    endif
endif
