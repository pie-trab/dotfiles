#!/bin/bash

if [ -e ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc_old
fi
cp ./vimrc ~/.vimrc

if [ -d ~/.vim/colors ]; then
    mv ~/.vim/colors ~/.vim/colors_old
fi

if [ ! -d ~/.vim ]; then 
    mkdir ~/.vim
fi
cp -r ./colors ~/.vim/

