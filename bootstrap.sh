#!/usr/bin/env bash -u

SPP_HOME=${HOME}/.spp

ITERM_PLIST_PATH=${HOME}/Library/Preferences/com.googlecode.iterm2.plist

function install() {
    if [ ! $(brew list | grep $1 2>/dev/null) ]; then
        brew install $1
    fi
}

function clean() {
    echo cleaning env...
    if [ $FORCE ]; then
        echo you are using the force...
        rm -rf $SPP_HOME
        rm ${HOME}/.vimrc ${HOME}/.vim ${HOME}/.tmux.conf ${HOME}/.gitconfig
        /usr/libexec/PlistBuddy -c "Delete :'Custom Color Presets':'Solarized Light' dict" $ITERM_PLIST_PATH 2> /dev/null
        /usr/libexec/PlistBuddy -c "Delete :'Custom Color Presets':'Solarized Dark' dict" $ITERM_PLIST_PATH 2> /dev/null
        echo cleaned
    fi
}

function install_vim() {
    echo bootstraping env...

    if [ -d "$SPP_HOME" ]; then
        echo Error: ~/.spp already exists
        exit 1
    fi

    git clone https://github.com/sppiotrowski/dotfiles.git $SPP_HOME
    git clone https://github.com/gmarik/vundle.git ${SPP_HOME}/vim/bundle/vundle

    # setup vim env
    ln -s ${SPP_HOME}/vimrc ${HOME}/.vimrc
    ln -s ${SPP_HOME}/vim ${HOME}/.vim

    # fonts for powerline
    cp ${SPP_HOME}/fonts/* ${HOME}/Library/Fonts
}


function install_tmux() {
    install 'tmux'
    ln -s ${SPP_HOME}/tmux/tmux.conf ${HOME}/.tmux.conf
}

function install_git() {
    install 'git'
    ln -s ${SPP_HOME}/git/gitconfig ${HOME}/.gitconfig
}

function configure_iterm() {
    cd $SPP_HOME

    /usr/libexec/PlistBuddy -c "Add  :'Custom Color Presets':'Solarized Light' dict" $ITERM_PLIST_PATH
    /usr/libexec/PlistBuddy -c "Merge 'iTerm2/Solarized Light.itermcolors' :'Custom Color Presets':'Solarized Light'" $ITERM_PLIST_PATH
    /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Solarized Dark' dict" $ITERM_PLIST_PATH
    /usr/libexec/PlistBuddy -c "Merge 'iTerm2/Solarized Dark.itermcolors' :'Custom Color Presets':'Solarized Dark'" $ITERM_PLIST_PATH

    dark_scheme_path="iTerm2/Solarized Dark.itermcolors"
    light_scheme_path="iTerm2/Solarized Light.itermcolors"
    # TODO: should user be asked?
    color_scheme_path=${dark_scheme_path}

    colors=('Background Color' 'Bold Color' 'Cursor Color' 'Cursor Text Color' 'Foreground Color' 'Selected Text Color' 'Selection Color')
    for c in $(seq 16); do
        color=$((c-1))
        colors+=("Ansi $color Color")
    done
    for color in "${colors[@]}"; do
        /usr/libexec/PlistBuddy -c "Delete :'New Bookmarks':0:'${color}'" $ITERM_PLIST_PATH
    done
    /usr/libexec/PlistBuddy -c "Merge '${color_scheme_path}' :'New Bookmarks':0" $ITERM_PLIST_PATH
}

function show_usage() {
    echo usage: ./bootstrap.sh or ./bootstrap.sh -f for force installing
}

function install_all() {
    install_vim
    install_tmux
    install_git
    configure_iterm
}

if [ ! $* ]; then
    FORCE=
    clean && install_all
else
    while getopts hf flag; do
        case $flag in
            f)
                FORCE=true
                clean && install_all
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
