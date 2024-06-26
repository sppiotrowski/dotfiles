" Disable vim distribution plugins
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logiPat = 1
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:netrw_nogx = 1 " disable netrw's gx mapping.
let g:loaded_rrhelper = 1  " ?
let g:loaded_shada_plugin = 1  " ?
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

" :help cmdline-history
set history=1000

" Tabs and indents
set textwidth=80    " Text width maximum chars before wrapping
set expandtab       " Expand tabs to spaces.
set tabstop=2       " The number of spaces a tab is
set softtabstop=2   " While performing editing operations
set shiftwidth=2    " Number of spaces to use in auto(indent)
set smarttab        " Tab insert blanks according to 'shiftwidth'
set autoindent      " Use same indenting on new lines
set smartindent     " Smart autoindenting on new lines
set shiftround      " Round indent to multiple of 'shiftwidth'

" Timing
set timeout ttimeout
set timeoutlen=750  " Time out on mappings
set updatetime=400  " Idle time to write swap and trigger CursorHold
set ttimeoutlen=10  " Time out on key codes

" Searching
" set ignorecase      " Search ignoring case
set smartcase       " Keep case when searching with *
set infercase       " Adjust case in insert completion mode
set incsearch       " Incremental search
set wrapscan        " Searches wrap around the end of the file
set showmatch       " Jump to matching bracket
set matchpairs+=<:> " Add HTML brackets to pair matching
set matchtime=1     " Tenths of a second to show the matching paren
set cpoptions-=m    " showmatch will wait 0.5s or until a char is typed
set showfulltag     " Show tag and tidy search in completion

" Behavior
set nowrap                      " No wrap by default
set linebreak                   " Break long lines at 'breakat'
set breakat=\ \	;:,!?           " Long lines break chars
set nostartofline               " Cursor in same column for few commands
set whichwrap+=h,l,<,>,[,],~    " Move to following line on certain keys
set splitbelow splitright       " Splits open bottom right
set switchbuf=useopen,usetab    " Jump to the first open window in any tab
set switchbuf+=vsplit           " Switch buffer behavior to vsplit
set hidden                      " allow to switch the buffer without saving
set backspace=indent,eol,start  " Intuitive backspacing in insert mode
set diffopt=filler,iwhite       " Diff mode: show fillers, ignore whitespace
set completeopt=menuone         " Always show menu, even for one item
set completeopt+=noselect       " Do not select a match in the menu

" Editor UI
set noshowmode          " Don't show mode in cmd window
set shortmess=aoOTI     " Shorten messages and don't show intro
set scrolloff=2         " Keep at least 2 lines above/below
set sidescrolloff=5     " Keep at least 5 lines left/right
set nonumber            " Don't show line numbers
set noruler             " Disable default status ruler
set list                " Show hidden characters

set winwidth=30         " Minimum width for active window
set winminwidth=10      " Minimum width for inactive windows
set winheight=4         " Minimum height for active window
set winminheight=1      " Minimum height for inactive window
set pumheight=15        " Pop-up menu's line height
set helpheight=12       " Minimum help window height
set previewheight=12    " Completion preview height

set showcmd             " Show command in status line
set cmdheight=2         " Height of the command line
set cmdwinheight=5      " Command-line lines
set equalalways         " Resize windows on split or close
set laststatus=2        " Always show a status line
set display=lastline

" Macros
nnoremap Q q
nnoremap gQ @q

" UI Symbols
set showbreak=↪
set listchars=tab:\▏\ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·
set shortmess+=c " Do not display completion messages
set shortmess+=F " Do not display message when editing files

" disable backup
set noswapfile
set nobackup
set nowritebackup
set noundofile
if has('nvim')
  set shada="NONE"
else
  set viminfo="NONE"
endif

if &compatible
 set nocompatible
endif

filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting


call plug#begin()
  Plug 'tpope/vim-fugitive'  " :GGrep
  Plug 'tpope/vim-rhubarb'   " :GBrowser
  Plug 'tpope/vim-surround'
  " Plug 'tpope/vim-sensible' " TODO: vim defaults
  Plug 'prabirshrestha/vim-lsp'

  Plug 'sheerun/vim-polyglot'
  Plug 'scrooloose/nerdtree'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'dense-analysis/ale'
  " Plug 'iCyMind/NeoSolarized'
  " Plug 'morhetz/gruvbox'
  Plug 'rebelot/kanagawa.nvim'
  " Plug 'chemzqm/vim-easygit'
  Plug 'romainl/vim-cool'
  " Plug 'itchyny/lightline.vim'
  " Plug 'ludovicchabant/vim-gutentags'
  " Plug 'luochen1990/rainbow'
  " Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
  Plug 'junegunn/goyo.vim'
  " Plug 'sonph/onehalf', {'rtp': 'vim/'}
  " Plug 'aperezdc/vim-template'

  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'github/copilot.vim'
call plug#end()

" Github Copilot
let g:copilot_node_command = "/usr/local/n/versions/node/18.19.0/bin/node"

" vim-grep
" nnoremap gr :<C-u>Grep<Space>
" nnoremap <silent> K :<C-u>Grep<CR>
" vnoremap <silent> K :Grep<CR>
" nnoremap <Leader>g :Grep<CR>

" vim-cool
let g:CoolTotalMatches = 1

" vim-easygit
let g:easygit_enable_command = 1

let g:mapleader = ','

noremap <silent> <Leader>d :Goyo<Return>
nnoremap <leader>s :set invspell<CR>

" NERDTree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
map <Leader>n :NERDTreeToggle<CR>
map <Leader>r :NERDTreeFind<CR>

" Ale
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier', 'eslint']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['scss'] = ['stylelint']
" let g:ale_fix_on_save = 1 " Fix files automatically on save
let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}

" #FZF
let g:fzf_command_prefix = 'Fzf'
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

command! -bang -nargs=+ GGrep1 call s:fzf_git_grep('<args>')
function! s:fzf_git_grep(args) abort
  let dir = s:get_git_base_path(expand("%:p:h"))
  if dir == -1
    echo 'file not found .git'
    return
  endif
  call fzf#run({
      \ 'source': 'git grep -n -I ' . a:args,
      \ 'sink': function('s:line_handler'),
      \ 'dir': dir,
      \ 'up': '~40%',
      \ 'options': '+m'
      \ })
endfunction

nnoremap <Leader>b :FzfBuffers<CR>
nnoremap <Leader>h :FzfHistory<CR>
nnoremap <Leader>t :FzfBTags<CR>
nnoremap <Leader>T :FzfTags<CR>
" nnoremap <Leader>f :FzfFiles<CR>
nnoremap <Leader>f :FzfGitFiles --exclude-standard --others --cached<CR>
" nnoremap <Leader>g :FzfRg<CR>
nnoremap <Leader>g :Ggrep<CR>
nnoremap <Leader>af :ALEFix<CR>
nnoremap <Leader>an :ALENext<CR>

set termguicolors
colorscheme kanagawa
" set background=light
set background=dark

" rainbow
let g:rainbow_active = 1
