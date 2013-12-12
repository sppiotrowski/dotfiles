" configuration stolen from:
" * https://github.com/skwp/dotfiles/blob/master/vim/vundles.vim

" ========================================
" Vim plugin configuration
" ========================================
"
" This file contains the list of plugin installed using vundle plugin manager.
" Once you've updated the list of plugin, you can run vundle update by issuing
" the command :BundleInstall from within vim or directly invoking it from the
" command line with the following syntax:
" vim --noplugin -u vim/vundles.vim -N "+set hidden" "+syntax on" +BundleClean! +BundleInstall +qall
" Filetype off is required by vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle (required)
Bundle "gmarik/vundle"

" All your bundles here
" Python


" Other languages
"Bundle "briancollins/vim-jst"
"Bundle "pangloss/vim-javascript"

" Html, Xml, Css, Markdown...
"Bundle "claco/jasmine.vim"
"Bundle "digitaltoad/vim-jade.git"
"Bundle "groenewege/vim-less.git"
"Bundle "itspriddle/vim-jquery.git"
"Bundle "jtratner/vim-flavored-markdown.git"
"Bundle "kchmck/vim-coffee-script"
"Bundle "nelstrom/vim-markdown-preview"
"Bundle "skwp/vim-html-escape"
"Bundle "slim-template/vim-slim.git"
"Bundle "timcharper/textile.vim.git"
"Bundle "tpope/vim-haml"
"Bundle "wavded/vim-stylus"

" --> Git related...
if executable('git')
    "Bundle "gregsexton/gitv"
    "Bundle "mattn/gist-vim"
    "Bundle "skwp/vim-git-grep-rails-partial"
    Bundle "tjennings/git-grep-vim"

    " Git wrapper
    Bundle "tpope/vim-fugitive"

    "Bundle "tpope/vim-git"
endif

" --> General text editing improvements...

" Switch between a single-line statement and a multi-line one
Bundle "AndrewRadev/splitjoin.vim"
"
" Provides automatic closing of quotes, parenthesis, brackets, etc.
Bundle "Raimondi/delimitMate"

" Performs keyword completion by maintaining a cache of keywords
Bundle "Shougo/neocomplcache.git"

Bundle "briandoll/change-inside-surroundings.vim.git"
Bundle "garbas/vim-snipmate.git"

" Line up text easily
Bundle "godlygeek/tabular"
Bundle "honza/vim-snippets"
Bundle "nelstrom/vim-visual-star-search"

" Dynamic buffer switcher vim plugin - lusty jugler
" Dynamic filesystem and buffer explorer - lusty explorer
Bundle "sjbach/lusty"

" Provide a much simpler way to use some motions in Vim
"Bundle "skwp/vim-easymotion"

Bundle "tomtom/tcomment_vim.git"
Bundle "tpope/vim-bundler"
Bundle "vim-scripts/IndexedSearch"

" Refine words motion in Vim
Bundle "vim-scripts/camelcasemotion.git"

" Extend matching with "%"
Bundle "vim-scripts/matchit.zip.git"

" Provide Sublime Text's awesome multiple selection feature to vim
Bundle "terryma/vim-multiple-cursors"

" General vim improvements
Bundle "MarcWeber/vim-addon-mw-utils.git"
Bundle "bogado/file-line.git"
Bundle "kien/ctrlp.vim"

" Lern by hard how to use vim movements
Bundle "wikitopian/hardmode"

if executable('ctags')
    " Browse the tags of source code files
    Bundle "majutsushi/tagbar.git"
    " Automated tag generation and syntax highlighting in Vim
    Bundle "xolox/vim-easytags"
endif

"Bundle "mattn/webapi-vim.git"

" A front for ag, A.K.A. the_silver_searcher
if executable('ag')
    Bundle "rking/ag.vim"
endif

" Explore filesystem and to open files and directories
Bundle "scrooloose/nerdtree.git"
Bundle "jistr/vim-nerdtree-tabs.git"

" Syntax check that runs files through external syntax checkers
Bundle "scrooloose/syntastic.git"

" Visualize Vim undo tree
Bundle "sjl/gundo.vim"

"Bundle "skwp/YankRing.vim"
Bundle "skwp/greplace.vim"
Bundle "skwp/vim-conque"
Bundle "tomtom/tlib_vim.git"

" Search for, substitute, and abbreviate multiple variants of a word
Bundle "tpope/vim-abolish"
Bundle "tpope/vim-endwise.git"
"Bundle "tpope/vim-ragtag"
Bundle "tpope/vim-repeat.git"
Bundle "tpope/vim-surround.git"

" Complementary pairs of mappings
Bundle "tpope/vim-unimpaired"
Bundle "vim-scripts/AnsiEsc.vim.git"

" Updates entries in a tags file automatically when saving
Bundle "vim-scripts/AutoTag.git"
Bundle "vim-scripts/lastpos.vim"
Bundle "vim-scripts/sudo.vim"
Bundle "xsunsmile/showmarks.git"
Bundle "terryma/vim-multiple-cursors"
"vim-misc is required for other plugins
Bundle "xolox/vim-misc"
"Bundle "xolox/vim-session"

" --> Text objects
" Text objects based on indent levels
Bundle "austintaylor/vim-indentobject"

"Bundle "bootleq/vim-textobj-rubysymbol"
Bundle "coderifous/textobj-word-column.vim"
Bundle "kana/vim-textobj-datetime"
Bundle "kana/vim-textobj-entire"
Bundle "kana/vim-textobj-function"
Bundle "kana/vim-textobj-user"
Bundle "michaeljsmith/vim-indent-object"
"Bundle "lucapette/vim-textobj-underscore"

" Visually display indent levels in Vim
Bundle "nathanaelkane/vim-indent-guides"
"Bundle "nelstrom/vim-textobj-rubyblock"
"Bundle "thinca/vim-textobj-function-javascript"
Bundle "vim-scripts/argtextobj.vim"
"
"" Cosmetics, color scheme, Powerline...
Bundle "chrisbra/color_highlight.git"
Bundle "skwp/vim-colors-solarized"
Bundle "bling/vim-airline.git"
Bundle "vim-scripts/TagHighlight.git"
Bundle "bogado/file-line.git"
" rope-vim requires: rope and ropemode
Bundle "klen/rope-vim"
" require autopep8
Bundle "hhatto/autopep8"
Bundle "hynek/vim-python-pep8-indent"

" --> New, to check
" Provide many different commenting operations and styles
"Bundle "scrooloose/nerdcommenter"


" Compile or run a single source file without leaving Vim
"Bundle "xuhdev/SingleCompile"

" Focus on a region and making the rest inaccessible
" Bundle "chrisbra/NrrwRgn"

" Search and display information from arbitrary sources
"Bundle "Shougo/unite.git"

" Easily interact with tmux from vim
"Bundle "benmills/vimux"

" Make operating on columns of code conceptually simpler and reduces keystrokes
"Bundle "coderifous/textobj-word-column.vim"

" Provide your Vim's buffer with the outline view
"Bundle "h1mesuke/unite-outline"

" Manage windows more convenient
"Bundle "zhaocai/GoldenView.Vim"

" Show a git diff in the 'gutter' (sign column).
"Bundle "airblade/vim-gitgutter"



"Filetype plugin indent on is required by vundle
filetype plugin indent on
