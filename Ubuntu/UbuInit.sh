echo *******************************************************
echo ************ sourse.list repository change ************
echo *******************************************************

sudo sed -i 's/ports.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove

echo **********************************************
echo ************ install gcc g++ make ************
echo **********************************************
sudo apt -y install gcc g++ make

echo ****************************************
echo ************ nodejs install ************
echo ****************************************
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
sudo apt -y install nodejs

echo **************************************
echo ************ yarn install ************
echo **************************************
echo curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt-get install yarn

echo *******************************************
echo ************ node-sass install ************
echo *******************************************
sudo yarn add global --force node-sass

echo *******************************************
echo ************ docker install ************
echo *******************************************
sudo apt-get -y install docker.io
