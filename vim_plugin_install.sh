#!/bin/bash

function install_package {
    echo -en "${Yellow}Check $1 ... "
    found=$(dpkg-query -W -f='${Status}\n' $1 | grep -c "ok installed")
    if [ $found -eq 0 ]; then
        echo -e "need download$Color_Off"
        sudo apt-get install $1
    else
        echo -e "${Green}exist"
    fi
    echo -en "$Color_Off"
}

function download_plugin {
    echo -en "${Yellow}Check $1 plugin ... "
    if [ -d ${START_DIR}/$1 ]; then
        echo -e "${Green}exist"
    else
        echo -e "need download$Color_Off"
        git clone $2 ${START_DIR}/$1
        [ -d ${START_DIR}/$1/doc ] && vim -u NONE -c "helptags ${START_DIR}/$1/doc" -c q
    fi   
    echo -en "$Color_Off"
}

Color_Off='\033[0m'
Yellow='\033[0;33m'
Green='\033[0;32m'

# install packages
install_package exuberant-ctags
install_package cscope

# vim pack
START_DIR=$HOME/.vim/pack/my_plugins/start
OPT_DIR=$HOME/.vim/pack/my_plugins/opt

mkdir -p ${START_DIR}
mkdir -p ${OPT_DIR}

# download plugins
download_plugin cscope https://github.com/joe-skb7/cscope-maps.git
download_plugin nerdtree https://github.com/preservim/nerdtree.git 
download_plugin tagbar https://github.com/preservim/tagbar.git
download_plugin file-line https://github.com/bogado/file-line.git
download_plugin vim-airline https://github.com/vim-airline/vim-airline.git
download_plugin syntastic https://github.com/vim-syntastic/syntastic.git
download_plugin hybrid https://github.com/w0ng/vim-hybrid.git
