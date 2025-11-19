#!/usr/bin/env bash

if [[ ${@: -1} == "--debug" ]]; then
    set -x
fi


function main {
    if [ "$#" -lt 1 ]; then
        echo ""
        echo "Pls $0 dev|server|graphic [--debug]"
        exit 1
    fi
    mode=$1

    if [[ $mode == "dev" ]]; then
        DEV_ENABLE="true"
        GRAPHIC_ENABLE="false"
    elif [[ $mode == "graphic" ]]; then
        DEV_ENABLE="true"
        GRAPHIC_ENABLE="true"
    else
        DEV_ENABLE="false"
        GRAPHIC_ENABLE="false"
    fi

    install_vim $DEV_ENABLE
    install_aliases
    install_zsh $DEV_ENABLE
    install_alacritty $GRAPHIC_ENABLE
}

function install_vim {
    # install vim
    echo "Installing vimrc"
    SCRIPT_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    DEV_ENABLE=$1

    VIM_PATH="vimrc"
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
        echo "    - Installing vim plugins"
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
    ALIAS_FILENAME="aliases"
    # install aliases
    if [ -f "$HOME/.aliases" ]; then
        rm -f $HOME/.aliases.old
        mv $HOME/.aliases $HOME/.aliases.old
        ln -s $SCRIPT_PATH/$ALIAS_FILENAME $HOME/.aliases
    else
        rm -f $HOME/.aliases
        ln -s $SCRIPT_PATH/$ALIAS_FILENAME $HOME/.aliases
    fi

}

function install_zsh {
    # install zshrc
    # Install zim: https://zimfw.sh/docs/install/
    # curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
    if [[ $DEV_ENABLE == "true" ]]; then
        ZSH_PATH=".zim" # only install if zim is installed
        ZSH_CONF_FILE="zshrc"
        if [ -d $HOME/$ZSH_PATH ]; then
            echo "Installing zshrc"
            if [ -f "$HOME/.zshrc" ]; then
                rm -f $HOME/.zshrc.old
                mv $HOME/.zshrc $HOME/.zshrc.old
                ln -s $SCRIPT_PATH/$ZSH_CONF_FILE $HOME/.zshrc
            else
                rm -f $HOME/.zshrc
                ln -s $SCRIPT_PATH/$ZSH_CONF_FILE $HOME/.zshrc
            fi
            #cp $SCRIPT_PATH/$ZSH_PATH/themes/* $HOME/$ZSH_PATH/themes/
        fi
    fi
}

function install_alacritty {
    GRAPHIC_ENABLE=$1
    if [[ $GRAPHIC_ENABLE == "true" ]]; then
        echo "Installing alacritty"
        ALACRITTY_PATH="alacritty"
        CONFIG_DIR="$HOME/.config/alacritty"

        if [ ! -d "$CONFIG_DIR" ]; then
            mkdir -p "$CONFIG_DIR"
        fi

        # install alacritty.toml
        if [ -f "$CONFIG_DIR/alacritty.toml" ]; then
            rm -f "$CONFIG_DIR/alacritty.toml.old"
            mv "$CONFIG_DIR/alacritty.toml" "$CONFIG_DIR/alacritty.toml.old"
        fi
        ln -s "$SCRIPT_PATH/$ALACRITTY_PATH/alacritty.toml" "$CONFIG_DIR/alacritty.toml"

        # install themes
        if [ -d "$CONFIG_DIR/themes" ]; then
            rm -rf "$CONFIG_DIR/themes.old"
            mv "$CONFIG_DIR/themes" "$CONFIG_DIR/themes.old"
        fi
        ln -s "$SCRIPT_PATH/$ALACRITTY_PATH/themes" "$CONFIG_DIR/themes"
    fi
}

main "$@"
