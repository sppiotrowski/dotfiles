" disable gbim toolbar and scroll bars
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" vim status line
set laststatus=2   "show lightline
let g:lightline = {'colorscheme': 'solarized'}

" make it beautiful - colors and fonts
set guifont=Inconsolata\ 12
colorscheme solarized
set background=dark
