#!/usr/bin/env bash

if [[ ${@: -1} == "--debug" ]]; then
    set -x
fi

function install {
    SCRIPT_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

    # install vim
    VIM_PATH="dotvim"
    if [ -d "$HOME/.vim" ]; then
        rm $HOME/.vim/vimrc
        ln -s $SCRIPT_PATH/$VIM_PATH/vimrc $HOME/.vim/vimrc
        #
        rm $HOME/.vim/plugins.vim
        ln -s $SCRIPT_PATH/$VIM_PATH/plugins.vim $HOME/.vim/plugins.vim
        #
        rm -f $HOME/.vim/syntax.old
        mv $HOME/.vim/syntax $HOME/syntax.old
        ln -s $SCRIPT_PATH/$VIM_PATH/syntax $HOME/.vim/syntax
    fi
    if [ -f "$HOME/.vimrc" ]; then
        rm -f $HOME/.vimrc.old
        mv $HOME/.vimrc $HOME/.vimrc.old
        ln -s $HOME/.vim/vimrc $HOME/.vimrc
    else
        rm -f $HOME/.vimrc
        ln -s $HOME/.vim/vimrc $HOME/.vimrc
    fi

    # install aliases
    if [ -f "$HOME/.aliases" ]; then
        rm -f $HOME/.aliases.old
        mv $HOME/.aliases $HOME/.aliases.old
        ln -s $SCRIPT_PATH/.aliases $HOME/.aliases
    else
        rm -f $HOME/.aliases
        ln -s $SCRIPT_PATH/.aliases $HOME/.aliases
    fi

    # install zshrc
    ZSH_PATH=".oh-my-zsh"
    if [ -f "$HOME/.zshrc" ]; then
        rm -f $HOME/.zshrc.old
        mv $HOME/.zshrc $HOME/.zshrc.old
        ln -s $SCRIPT_PATH/.zshrc $HOME/.zshrc
    else
        rm -f $HOME/.zshrc
        ln -s $SCRIPT_PATH/.zshrc $HOME/.zshrc
    fi
    cp $SCRIPT_PATH/$ZSH_PATH/themes/* $HOME/$ZSH_PATH/themes/
}

install
