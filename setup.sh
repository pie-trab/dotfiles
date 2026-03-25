#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f "$0"))

TEMP="$HOME/repos/dotfiles/fakehome"

confirm() {
    while true; do
        read -p "$1 (y/N): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* | "" ) return 1;;
            * ) echo "Not valid. Insert y, n or press ENTER.";;
        esac
    done
}

### install software ###
if confirm "Install software?"; then
    PACKAGES=(
        "vim"
        "git"
        "curl"
        "zsh"
        "tmux"
        "htop"
        "fzf"
        "ghostty"
    )

    printf "What software do you want to install?\nDefault package list:\n"
    printf " %s\n" "${PACKAGES[@]}";
    read -p "List packages separated by space or press ENTER to continue: " USR_PACKAGES
    # check if USR_PACKAGES is empty
    if [[ ! -z $USR_PACKAGES ]]; then
        PACKAGES=($USR_PACKAGES)
    fi

  # printf "%s; " "${PACKAGES[@]}"; printf "\n"

    echo "[SETUP] Updating and installing software: ${PACKAGES[@]}"
    if [[ $(source /etc/os-release; echo $ID) == "fedora" ]]; then
        for i in "${PACKAGES[@]}"; do
            if [[ "$i" == "ghostty" ]]; then
                sudo dnf copr enable scottames/ghostty -y # fedora ghostty copr
                break
            fi
        done
        sudo dnf update -y
        sudo dnf install -y "${PACKAGES[@]}"
    fi
    if [[ $(source /etc/os-release; echo $ID) == "ubuntu" ||
        $(source /etc/os-release; echo $ID) == "debian" ]]; then
        sudo apt update && sudo apt upgrade -y
        sudo apt install -y "${PACKAGES[@]}"
    fi
fi
### end install software ###

### vim configuration ###
if command -v vim &> /dev/null && confirm "Configure vim?"; then
    if [ -e $TEMP/.vimrc ]; then
        echo "[SETUP] Found .vimrc file, saved to .vimrc.old"
        mv $TEMP/.vimrc $TEMP/.vimrc.old
    fi
    echo "[SETUP] Adding .vimrc file to $TEMP"
    cp $SCRIPT_DIR/vimrc $TEMP/.vimrc

    if [ ! -d $TEMP/.vim ]; then
        echo "[SETUP] Created $TEMP/.vim directory"
        mkdir $TEMP/.vim
    fi

    if [ -d $TEMP/.vim/colors ]; then
        echo "[SETUP] Found $TEMP/.vim/colors directory, saved to $TEMP/.vim/colors.old"
        mkdir -p $TEMP/.vim/colors.old
        mv $TEMP/.vim/colors/* $TEMP/.vim/colors.old
    fi

    echo "[SETUP] Created $TEMP/.vim/colors and copied themes"
    mkdir -p $TEMP/.vim/colors
    cp $SCRIPT_DIR/colors/* $TEMP/.vim/colors/
fi
### end vim configuration ###

### zsh configuration ###
if command -v zsh &> /dev/null && confirm "Configure zsh?"; then
    SHELL_NAME=$SHELL

    if [[ ${SHELL_NAME: -3} != "zsh" ]]; then
        echo "[SETUP] zsh not found. Installing zsh..."
        if [[ $(source /etc/os-release; echo $ID) == "fedora" ]]; then
            sudo dnf install -y zsh
        fi
        if [[ $(source /etc/os-release; echo $ID) == "ubuntu" ||
            $(source /etc/os-release; echo $ID) == "debian" ]]; then
        sudo apt install -y zsh
        fi
    else
        echo "[SETUP] zsh found."
    fi

    if [ -e $TEMP/.zshrc ]; then
        echo "[SETUP] Found .zshrc file, saved to .zshrc.old"
        mv $TEMP/.zshrc $TEMP/.zshrc.old
    fi
    echo "[SETUP] Adding .zshrc file to $TEMP"
    cp $SCRIPT_DIR/zshrc $TEMP/.zshrc
    echo "[SETUP] zsh installed. Run \`chsh -s \$(which zsh)\` to set it as your default shell"
fi
### end zsh configuration ###

### tmux configuration ###
if command -v tmux &> /dev/null && confirm "Configure tmux?"; then
    if [ -e $TEMP/.tmux.conf ]; then
        echo "[SETUP] Found .tmux.conf file, saved to .tmux.conf.old"
        mv $TEMP/.tmux.conf $TEMP/.tmux.conf.old
    fi
    echo "[SETUP] Adding .tmux.conf file to $TEMP"
    cp $SCRIPT_DIR/tmux.conf $TEMP/.tmux.conf
fi
### end tmux configuration ###

### ghostty configuration ###
if command -v ghostty &> /dev/null && confirm "Configure ghostty?"; then
    if [ -d $TEMP/.config/ghostty ]; then
        echo "[SETUP] Fount $TEMP/.config/ghostty, moving it to $TEMP/.config/ghostty.old"
        mv $TEMP/.config/ghostty $TEMP/.config/ghostty.old
    fi

    cp -r $SCRIPT_DIR/ghostty $TEMP/.config/
fi
### end ghostty configuration ###
