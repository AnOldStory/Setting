#!/bin/bash

# Setting-Manager-Bash v1.0.0
# for Linux

# Configure 

setting_list="https://setting.anoldstory.com"

echo import setting
import_setting(){
    cd ~/

    #vim
    mkdir -p ~/.vim/colors
    wget "https://www.vim.org/scripts/download_script.php?src_id=26557" -P ~/.vim/colors/ -O ~/.vim/colors/jellybeans.vim
    wget $setting_list/.vimrc -q

    # TODO: zsh

    # TODO: bash

    # TODO: tmux
    echo import setting ok!
}

import_setting

echo complete!