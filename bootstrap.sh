#!/usr/bin/env bash

if [[ ${@: -1} == "--debug" ]]; then
    set -x
fi


function main {
    if [ "$#" -ne 1 ]; then
        echo ""
        echo "Pls $0 dev|server [--debug]"
        exit 1
    fi
    dev_enable=$1

    if [[ $dev_enable == "dev" ]]; then
        DEV_ENABLE="true"
    else
        DEV_ENABLE="false"
    fi

    install_vim $DEV_ENABLE
    install_aliases
    install_zsh $DEV_ENABLE
}

function install_vim {
    # install vim
    echo "Installing vimrc"
    SCRIPT_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    DEV_ENABLE=$1

    VIM_PATH="dotvim"
    if [ ! -d "$HOME/.vim" ]; then
        mkdir -p $HOME/.vim
    else
        rm -f $HOME/.vim.old
        mv $HOME/.vim $HOME/.vim.old
        mkdir -p $HOME/.vim
    fi

    ln -s $SCRIPT_PATH/$VIM_PATH/vimrc $HOME/.vim/vimrc
    #
    if [[ $DEV_ENABLE == "true" ]]; then
        ln -s $SCRIPT_PATH/$VIM_PATH/plugins.vim $HOME/.vim/plugins.vim
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
}

#function install_byobu_color {
#    # install aliases
#    if [ -f "$HOME/.byobu" ]; then
#        rm -f $HOME/.aliases.old
#        mv $HOME/.aliases $HOME/.aliases.old
#        ln -s $SCRIPT_PATH/.aliases $HOME/.aliases
#    else
#        rm -f $HOME/.aliases
#        ln -s $SCRIPT_PATH/.aliases $HOME/.aliases
#    fi
#
#}

function install_aliases {
    echo "Installing aliases"
    # install aliases
    if [ -f "$HOME/.aliases" ]; then
        rm -f $HOME/.aliases.old
        mv $HOME/.aliases $HOME/.aliases.old
        ln -s $SCRIPT_PATH/.aliases $HOME/.aliases
    else
        rm -f $HOME/.aliases
        ln -s $SCRIPT_PATH/.aliases $HOME/.aliases
    fi

}

function install_zsh {
    echo "Installing zshrc"
    # install zshrc
    if [[ $DEV_ENABLE == "true" ]]; then
        ZSH_PATH=".oh-my-zsh"
        if [ -d $HOME/$ZSH_PATH ]; then
            if [ -f "$HOME/.zshrc" ]; then
                rm -f $HOME/.zshrc.old
                mv $HOME/.zshrc $HOME/.zshrc.old
                ln -s $SCRIPT_PATH/.zshrc $HOME/.zshrc
            else
                rm -f $HOME/.zshrc
                ln -s $SCRIPT_PATH/.zshrc $HOME/.zshrc
            fi
            cp $SCRIPT_PATH/$ZSH_PATH/themes/* $HOME/$ZSH_PATH/themes/
        fi
    fi
}

main "$@"
