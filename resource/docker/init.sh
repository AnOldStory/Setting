#/bin/bash

# 

# default value
DATA_DIRECTORY="/HDD/docker"
PUID="1000"
PGID="1000"
PASSWORD="password"
PROXY_DOMAIN="code.anoldstory.com"

read_input() { #string
    read -p "Enter $1 [${1}]: " input
    input=${input:-${1}}
    return $input
}

##############################################################################################
#initial docker network settings
echo "setting docker network"
docker network create -d bridge Local-Host

##############################################################################################
#initial environment variables
echo "setting environment variables"

DATA_DIRECTORY=$(read_input DATA_DIRECTORY)

PUID=$(read_input PUID)

PGID=$(read_input PGID)

##############################################################################################
#install code-server

CURRENT_PROGRAM="code-server"
echo "Install $CURRENT_PROGRAM"

PASSWORD=$(read_input PASSWORD)
PROXY_DOMAIN=$(read_input PROXY_DOMAIN)

echo "Download Compose.yml"
mkdir -p $DATA_DIRECTORY/$CURRENT_PROGRAM
wget -q -P $DATA_DIRECTORY/$CURRENT_PROGRAM "https://raw.githubusercontent.com/AnOldStory/Setting/master/resource/docker/$CURRENT_PROGRAM/docker-compose.yml"

echo "Docker Compose"
docker-compose -f "$DATA_DIRECTORY/$CURRENT_PROGRAM/docker-compose.yml" up -d 

##############################################################################################
#install heimdall

CURRENT_PROGRAM="heimdall"
echo "Install $CURRENT_PROGRAM"

echo "Download Compose.yml"
mkdir -p $DATA_DIRECTORY/$CURRENT_PROGRAM
wget -q -P $DATA_DIRECTORY/$CURRENT_PROGRAM "https://raw.githubusercontent.com/AnOldStory/Setting/master/resource/docker/$CURRENT_PROGRAM/docker-compose.yml"

echo "Docker Compose"
docker-compose -f "$DATA_DIRECTORY/$CURRENT_PROGRAM/docker-compose.yml" up -d
