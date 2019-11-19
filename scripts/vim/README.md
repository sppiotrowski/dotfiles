# Vim
exec all commands from file
```sh
:source cmds.vim
```

open file and exec all commands
```sh
vim -s cmds.vim <file>
```

vim batch processing
```sh
# -E       > improved Ex mode
# -N       > no compatible
# -n  	   > no swapfile
# -s       > silent
# -u NONE  > no plugin

vim -ENns -u NONE "$FILE" <<EOF
:s/x/y/g
:x
EOF
```
