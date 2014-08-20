#!/usr/bin/env bash

set -u

SPP_HOME=${HOME}/.spp

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

function clean() {
    echo cleaning env
    if [ $FORCE ]; then
        echo you are using the force
        rm -rf $SPP_HOME
        rm $HOME/.vimrc
        rm $HOME/.gitconfig
        rm $HOME/.tmux.conf
        rm $HOME/.local/share/applications/sqldeveloper.desktop
        rm $HOME/.local/share/applications/eclipse.desktop
        rm $HOME/.tmuxinator
        rm $HOME/.vim
    fi
}

function make_dirs() {
    echo making dirs

    if [ -d "$SPP_HOME" ]; then
        echo Error: ~/.spp already exists
        exit 1
    fi

    ln -s ~/dev/spp ~/.spp

    # git clone https://github.com/sppiotrowski/dotfiles.git $SPP_HOME
    # git clone https://github.com/gmarik/vundle.git ${SPP_HOME}/vim/bundle/vundle
    ln -s $SPP_HOME/unity/eclipse.desktop $HOME/.local/share/applications/eclipse.desktop
    ln -s $SPP_HOME/unity/sqldeveloper $HOME/.local/share/applications/sqldeveloper.desktop
}

function setup_vim() {

    # setup vim env
    ln -s ${SPP_HOME}/vimrc ${HOME}/.vimrc
    ln -s ${SPP_HOME}/vim ${HOME}/.vim

    # install plugins via vundle
     vim --noplugin -u vim/vundles.vim -N "+set hidden" "+syntax on" +BundleClean! +BundleInstall +qall
}

function setup_tmux() {
    apt_install 'tmux'
    ln -s ${SPP_HOME}/tmux/tmux.conf ${HOME}/.tmux.conf

    gem_install tmuxinator
    ln -s $SPP_HOME/tmux/tmuxinator $HOME/.tmuxinator
}

function setup_git() {
    apt_install 'git'
    ln -s ${SPP_HOME}/gitconfig ${HOME}/.gitconfig
}

function show_usage() {
    echo usage: ./bootstrap.sh or ./bootstrap.sh -f for force installing
}

function setup_gdrive() {
    add-apt-repository ppa:thefanclub/grive-tools
    apt-get update

    apt_install 'grive-tools'
}

function bootstrap() {
    make_dirs
    setup_vim
    setup_tmux
    setup_git
    setup_gdrive
}

if [ ! $* ]; then
    FORCE=
    clean && bootstrap
else
    while getopts hf flag; do
        case $flag in
            f)
                FORCE=true
                clean && bootstrap
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

