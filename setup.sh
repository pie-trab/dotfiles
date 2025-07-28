#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ -e ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc_old
fi
cp $SCRIPT_DIR/vimrc ~/.vimrc

if [ -d ~/.vim/colors ]; then
    mv ~/.vim/colors ~/.vim/colors_old
fi

if [ ! -d ~/.vim ]; then 
    mkdir ~/.vim
fi
cp -r $SCRIPT_DIR/colors ~/.vim/

