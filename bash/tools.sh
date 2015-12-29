export ECLIPSE='eclipse-luna'
export JAVA_OPTS='-Xmx1024m -Xms512m -XX:MaxPermSize=256m'

alias xmind='XMind'
alias xclip='xclip -selection clipboard'

# git support
. ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\u:\W$(__git_ps1 "(%s)")\$ '

# vert.x
export PATH="$PATH:$HOME/dev/vert.x-2.1.6/bin"
