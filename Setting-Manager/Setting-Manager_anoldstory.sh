#!/bin/bash

# Setting-Manager-Bash v1.0.0
# for Ubuntu

# Configure 

setting_list="https://api.github.com/repos/AnOldStory/Setting/contents/resource/linux?ref=master"

echo 1. repository update
repository_update(){
    #change source to kakao 
    sudo sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
    
    #install yarn
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    #install node-version-manager 
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
    source ~/.bashrc
    
    #install 
    sudo apt-get update
    sudo apt-get -y upgrade
    sudo apt-get -y dist-upgrade
    sudo apt-get -y autoremove
}
 
echo 2. install package 
install_package(){
    nvm install node  # nodejs 
    sudo apt-get -y install yarn docker.io gcc g++ make git jq
    echo "export PATH=\"\$PATH:\$(yarn global bin)\"" >> .bashrc
    git config --global user.email "hc9904@hanyang.ac.kr"
    git config --global user.name "AnOldStory"
}
 
echo 3. import setting
import_setting(){
    cd ~/
    mkdir -p ~/.vim/colors
    wget "https://www.vim.org/scripts/download_script.php?src_id=26557" -O jellybeans.vim
    wget $setting_list -qO - | jq '.[0].download_url' | xargs wget
}