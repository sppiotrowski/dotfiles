" HACKING
" exec all commands from file
" :source cmds.vim

" open file and exec all commands
" vim -s cmds.vim <file>

" vim batch processing
" vim --noplugin -n -c 'set nomore' -S cmds.vim <file>

" rm lines - matching regex
:1;/defineMessages(/ d


" read to line 0 from template
:0r !awk '/TS1/{flag=1;next}/TE1/{flag=0}flag' ./template.vim

" add empty line
:$ | put=' '

" insert to line $ from template
:$r !awk '/TS2/{flag=1;next}/TE2/{flag=0}flag' ./template.vim


" from template using sed
":0r !sed -n -e '1,5p' ./template.vim
":$r !sed -n -e '6,7p' ./template.vim
