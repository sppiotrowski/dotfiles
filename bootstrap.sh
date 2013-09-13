#!/usr/bin/env bash -u

SPP_HOME="$HOME/.spp"


function clean() {
    echo 'cleaning env...'
    if [ $FORCE ]; then
        echo 'you are using the force...'
        rm -rf "$SPP_HOME"
        rm -rf "$HOME/.vimrc" "$HOME/.vim" "$HOME/.tmux.conf"
    fi
}

function install_vim() {
    echo 'bootstraping env...'

    if [ -d "$SPP_HOME" ]; then
        echo 'Error: ~/.spp already exists'
        exit 1
    fi

    git clone https://github.com/sppiotrowski/dotfiles.git "$SPP_HOME"
    git clone https://github.com/gmarik/vundle.git "$SPP_HOME/vim/bundle/vundle"

    # setup vim env
    ln -s "$SPP_HOME/vimrc" "$HOME/.vimrc"
    ln -s "$SPP_HOME/vim" "$HOME/.vim"

    # fonts for 'powerline'
    cp "$SPP_HOME/fonts/* $HOME/Library/Fonts"
}

function install_tmux() {
    brew install tmux
    ln -s "$SPP_HOME/tmux/tmux.conf " "$HOME/.tmux.conf"
}

function show_usage() {
    echo 'usage: ./bootstrap.sh or ./bootstrap.sh -f for force installing'
}

function install() {
    install_vim
}

if [ ! $* ]; then
    FORCE=''
    clean && install
else
    while getopts hf flag; do
        case $flag in
            f)
                FORCE=true
                clean && install
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
