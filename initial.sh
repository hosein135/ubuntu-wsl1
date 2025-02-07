#!/bin/bash
# Colors:
RED='\033[0;31m';
NC='\033[0m'; # No Color
GREEN='\033[0;32m';
YELLOW='\033[1;33m';
delay_after_message=3;
#update and upgrade
printf "${YELLOW}Updating packages${NC}\n";
sleep $delay_after_message;
sudo apt update -y &&
sudo apt upgrade -y &&
#Installing important packages
printf "${YELLOW}Installing important packages${NC}\n";
sleep $delay_after_message;
sudo apt install -y \
    build-essential \
    curl \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    llvm \
    make \
    tk-dev \
    wget \
    xz-utils \
    zlib1g-dev

sleep 2;
#Install git
printf "${YELLOW}Installing git${NC}\n";
sleep $delay_after_message;
sudo apt install git sed -y
sleep 2;
#Install github cli
printf "${YELLOW}github cli${NC}\n";
sleep $delay_after_message;
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
sleep 2;
#change git default branch name
printf "${YELLOW}change git default branch name to main${NC}\n";
sleep $delay_after_message;
git config --global init.defaultBranch main
sleep 2;
#Installing asdf
printf "${YELLOW}Installing asdf${NC}\n";
sleep $delay_after_message;
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc
source ~/.bashrc
asdf plugin add nodejs
sed -i 's/for client in aria2c curl wget; do/for client in curl wget; do/' ~/.asdf/plugins/nodejs/.node-build/bin/node-build
sleep 2;
#change git default editor
printf "${YELLOW}change git default editor to vscode${NC}\n";
sleep $delay_after_message;
git config --global core.editor "code --wait"
