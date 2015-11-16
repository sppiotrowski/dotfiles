" Support for github yaml-vim
" via https://github.com/ingydotnet/yaml-vim
augroup markdown
    au!
    au BufNewFile,BufRead *.yml,*.yaml setlocal filetype=yaml
augroup END
