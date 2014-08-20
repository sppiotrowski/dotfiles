#!/usr/bin/env bash

set -u

SPP_HOME=$HOME/.spp

function symlink() {
    if [ -e $2 ]; then
        echo "rm: $2"
        rm $2
    fi
    ln -s $1 $2
}

function apt_install() {
    if [ $(dpkg -l $1 | wc -l 2>/dev/null) == "0" ]; then
        echo "installing: $1"
        apt-get -yy install $1
    fi
}

function gem_install() {
    if [ $(gem list $1 -i) == "false" ]; then
        echo "installing: $1"
        gem install $1
    fi
}

function init_spp() {
    echo "exec: $0"

    if [ -d $SPP_HOME ]; then
        cd $SPP_HOME && git pull
    else
        git clone https://github.com/sppiotrowski/dotfiles.git $SPP_HOME
    fi

    symlink ~/dev/spp ~/.spp

    if [ ! -e $SPP_HOME/vim/bundle/vundle ]; then
        git clone https://github.com/gmarik/vundle.git $SPP_HOME/vim/bundle/vundle
    fi

}

function setup_unity() {
    echo "exec: $0"
    symlink $SPP_HOME/unity/eclipse.desktop $HOME/.local/share/applications/eclipse.desktop
    symlink $SPP_HOME/unity/sqldeveloper $HOME/.local/share/applications/sqldeveloper.desktop
}

function setup_vim() {
    echo "exec: $0"
    symlink $SPP_HOME/vimrc $HOME/.vimrc
    symlink $SPP_HOME/vim $HOME/.vim

    # install plugins via vundle
     vim --noplugin -u vim/vundles.vim -N "+set hidden" "+syntax on" +BundleClean! +BundleInstall +qall
}

function setup_tmux() {
    echo "exec: $0"
    apt_install tmux
    symlink $SPP_HOME/tmux/tmux.conf $HOME/.tmux.conf

    gem_install tmuxinator
    symlink $SPP_HOME/tmux/tmuxinator $HOME/.tmuxinator
}

function setup_git() {
    echo "exec: $0"
    apt_install 'git'
    symlink $SPP_HOME/gitconfig $HOME/.gitconfig
}

function show_usage() {
    echo usage: ./bootstrap.sh or ./bootstrap.sh -f for force installing
}

function setup_gdrive() {
    echo "exec: $0"
    add-apt-repository ppa:thefanclub/grive-tools
    apt-get update

    apt_install 'grive-tools'
}

function bootstrap() {
    [ -n $FORCE ] && rm -rf $SPP_HOME
    init_spp
    setup_unity
    setup_vim
    setup_tmux
    setup_git
    # setup_gdrive # skipped: time consuming:w
}

if [ ! $* ]; then
    bootstrap
else
    while getopts hf flag; do
        case $flag in
            f)
                FORCE=true
                bootstrap
                ;;
            h)
                show_usage
                ;;
            ?)
                show_usage
                ;;
        esac
    done
fi

