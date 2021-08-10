# Setting-Manager-Bash v1.0.0

echo **********************************************
echo ************ repository update  ************
echo **********************************************
sudo sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove
 
echo **********************************************
echo ********** node version manager  **********
echo **********************************************
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.bashrc
 
echo **********************************************
echo ************** import setting ***************
echo **********************************************
cd ~/
wget https://raw.githubusercontent.com/AnOldStory/Setting/master/Ubuntu/.vimrc 
 
 
echo **********************************************
echo ************** install package ***************
echo **********************************************
nvm install node  # nodejs 
sudo apt-get -y install yarn docker.io gcc g++ make git
echo "export PATH=\"\$PATH:\$(yarn global bin)\"" >> .bashrc
git config --global user.email "hc9904@hanyang.ac.kr"
git config --global user.name "AnOldStory"