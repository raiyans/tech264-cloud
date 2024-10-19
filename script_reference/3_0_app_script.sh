#!/bin/bash

MONGODB__HOST="mongodb://10.0.3.4:27017"

echo "Connect via our VMs via IP."
export DB_HOST=$MONGODB__HOST
echo "Connection complete."
echo "Set env variable"
printenv DB_HOST
echo "env variable set."

echo update sources list...
sudo apt-get update -y
echo Done!

echo upgrade any packages available...
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
echo Done!

echo install nginx...
sudo DEBIAN_FRONTEND=noninteractive apt-get install nginx -y
echo Done!

echo install nodejs v20...
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs
echo Done!

echo check nodejs version...
node -v
echo Done!

echo clone repo
#renames the repo downloaded to repo-folder
git clone https://github.com/raiyans/example-node-app.git repo-folder

echo  open app directory
cd repo-folder

echo set db host ip
export DB_HOST=mongodb://10.0.3.4:27017/posts

echo check env var set
printenv DB_HOST

echo run node app
npm install && npm start
