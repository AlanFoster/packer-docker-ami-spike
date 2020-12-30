#!/bin/bash

set -e -o pipefail

sudo apt-get update

# Install docker
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
    docker-ce \
    docker-ce-cli \
    containerd.io
sudo systemctl status docker | cat
