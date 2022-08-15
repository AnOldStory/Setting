#/bin/bash

#default value
DATA_DIRECTORY="/HDD/docker"
PUID="1000"
PGID="1000"
PASSWORD="password"
PROXY_DOMAIN="code.anoldstory.com"

function read_input(default_value) {
    read -p "Enter $default_value [$default_value]: " input
    if [ -z "$input" ]; then # check empty
        input=$default_value
    fi
    echo $input
}

##############################################################################################
#initial docker network settings
echo "setting docker network"
docker network create -d bridge Local-Host

##############################################################################################
#initial environment variables
echo "setting environment variables"

read -p "Enter Data Directory[${DATA_DIRECTORY}]:" input
DATA_DIRECTORY=${input:-$DATA_DIRECTORY}

read -p "Enter PUID[1000]:" input
PUID=${input:-$PUID}

read -p "Enter PGID[1000]:" input
PGID=${input:-$PGID}

##############################################################################################
#install code-server

CURRENT_PROGRAM="code-server"
echo "Install $CURRENT_PROGRAM"

read -p "Enter Password[${PASSWORD}]:" input
PASSWORD=${input:-$PASSWORD}

read -p "Enter Proxy Domain[$PROXY_DOMAIN]:" input
PROXY_DOMAIN=${input:-$PROXY_DOMAIN}

echo "Download Compose.yml"
mkdir -p $DATA_DIRECTORY/$CURRENT_PROGRAM
wget -q -P $DATA_DIRECTORY/$CURRENT_PROGRAM "https://raw.githubusercontent.com/AnOldStory/Setting/master/resource/docker/$CURRENT_PROGRAM/docker-compose.yml"

echo "Docker Compose"
docker-compose -f "$DATA_DIRECTORY/$CURRENT_PROGRAM/docker-compose.yml" up -d 