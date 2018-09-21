#!/bin/bash

# SET REPOSITORIES FOR DOCKER 

sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce


# DOCKER COMPOSE 

sudo curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# alternatively 
# sudo apt-get -y install python-pip
# sudo pip install docker-compose


# BASH COMPLETION 
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.20.1/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose


# IF NEEDED
# Create the docker group
sudo groupadd docker

# Add your user to the docker group.
sudo usermod -aG docker $USER

# If you initially ran Docker CLI commands using sudo before adding your user to 
# the docker group, you may see the following error, which indicates that your
# ~/.docker/ directory was created with incorrect permissions due to the sudo commands.

# FIX:
# sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
# sudo chmod g+rwx "/home/$USER/.docker" -R


# DOCKER TOOLS 
docker image pull docker/ucp:2.2.7

# Pull the latest version of UCP
$ docker image pull docker/ucp:2.2.7

# Install UCP
$ docker container run --rm -it --name ucp \
  -v /var/run/docker.sock:/var/run/docker.sock \
  docker/ucp:2.2.7 install \
  --host-address <node-ip-address> \
  --interactive

# Pull the latest version of DTR
$ docker pull docker/dtr:2.4.3

# Install DTR
$ docker run -it --rm \
  docker/dtr:2.4.3 install \
  --ucp-node <ucp-node-name> \
  --ucp-insecure-tls

