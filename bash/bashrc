# env vars


PPIT_ROOT=/home/spi/dev/ppit
SPP_HOME=/home/spi/.spp

export PPIT_ROOT=$PPIT_ROOT
export PPIT_CHECK_TEST_DB_CLEANUP=1

export JAVA_HOME="/usr/lib/jvm/java-6-oracle"
export VAGRANT_USE_NO_NFS="true"
export VAGRANT_DEBUG="true"
export EDITOR=vim

# git aliases
# alias .e.changed='cd ~/dev/ppit && vim $(git status --porcelain | awk "{print $2}")'

# aliases for edit a configuration
alias .e.bashrc="vim $SPP_HOME/bashrc"
alias .s.bashrc=". $SPP_HOME/bashrc"
alias .e.vimrc="vim $SPP_HOME/vimrc"

# aliases for change a directory
alias .cd="cd $PPIT_ROOT"
alias .cd.database="cd $PPIT_ROOT/database"

# aliases for invoke a project actions
alias .p.build="cd $PPIT_ROOT/build_all && ./build.sh && cd - "
alias .p.build.as="cd $PPIT_ROOT/build_all && ./buildAsOnly.sh && cd -"

# aliases for virtual box actions
alias .v.ssh="cd $PPIT_ROOT/devimage && ./sshx.sh"
alias .v.up="cd $PPIT_ROOT/devimage && vagrant up"
alias .v.sds="cd $PPIT_ROOT/devimage && ./sshx.sh './control.sh sds'"

alias .t="tree . -L 3"

# set -o vi
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# show git current branch in a bash prompt
export PS1='$(__git_ps1) \W\$ '

. $SPP_HOME/bash/git-completion.bash
. /var/lib/gems/1.9.1/gems/tmuxinator-0.6.8/completion/tmuxinator.bash
