#!/bin/bash
sudo apt update 
sudo apt upgrade --yes

sudo apt-get install software-properties-common --yes
sudo apt update

echo "Install Git"
sudo apt-get install git --yes

echo "Install Nginx"
sudo apt-get install nginx --yes

curl -s https://deb.nodesource.com/setup_18.x | sudo bash
sudo apt-get install nodejs --yes

node -v

sudo npm install pm2 -g

sudo npm install yarn -g
