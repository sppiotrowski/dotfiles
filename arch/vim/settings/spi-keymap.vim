"Go to last edit location with ,.
nnoremap ,. '.

" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
" this is helpful to paste someone the path you're looking at
" nnoremap <silent> ,cf :let @* = expand("%:~")<CR>
" nnoremap <silent> ,cn :let @* = expand("%:t")<CR>

nnoremap <silent> ,cf :let @+=expand("%")<CR>
nnoremap <silent> ,cn :let @+=expand("%:p")<CR>

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

"(v)im (r)eload
nmap <silent> ,vr :so %<CR>

" Type ,hl to toggle highlighting on/off, and show current value.
noremap ,hl :set hlsearch! hlsearch?<CR>

" Ctrl-C Ctrl-V
vnoremap <C-C> "+y
map <C-V> "+gP
noremap <C-Q> <C-V>
