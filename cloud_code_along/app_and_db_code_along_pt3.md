- [plan app+db image](#plan-appdb-image)
- [**app userdata script**](#app-userdata-script)
- [**db userdata script**](#db-userdata-script)
- [How to create image](#how-to-create-image)
- [script to rerun app vm from image](#script-to-rerun-app-vm-from-image)


## plan app+db image
1. created db vm using custom image
2. Tested user data did its job
3. create app vm using custom image and user data to run the entire app script
   - make sure the DB_HOST variable has the correct ip
4. Test by:
   - checking web page with the public ip 
   - check /posts page
5. Create DB VM image from the DB VM
   - delet the db VM
6. Create DB VM from the DB image
7. Create app VM image from the app VM
   - delete the app VM
8. Create app VM from the app image just created
   - special script - run-app-only.sh
     - start with she-bang
     - export DB_HOST
     - cd into the app folder
     - pm2 kill/stop
     - pm2 start app.js
     - dont worry about `npm install` already done for image
     - 
   - posts page to work connecting to database VM made from image


## **app userdata script**
```bash
#!/bin/bash

GITHUB_REPO="https://github.com/GP-Stanley/tech264-sparta-app"
REPO_FOLDER="repo"
NGINX_CONF="/etc/nginx/sites-available/default"
BACKUP_CONF="/etc/nginx/sites-available/default.bak"
MONGODB__HOST="mongodb://10.0.3.4:27017"

echo "Connect via our VMs via IP."
export DB_HOST=$MONGODB__HOST
echo "Connection complete."
echo "Set env variable"
printenv DB_HOST

echo "env variable set."
echo update sources list...
sudo apt update -y
echo Done.

echo upgrade any upgradable packages available...
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
echo Done.

echo install nginx...
sudo DEBIAN_FRONTEND=noninteractive apt-get install nginx -y
echo Done.

echo install nodejs v20...
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs
echo Done!

echo check nodejs version...
node -v
echo Done!

echo install pm2...
sudo npm install -g pm2
echo Done!

echo Cloning GitHub repository...
git clone $GITHUB_REPO $REPO_FOLDER
echo Done!

echo cd into the app file
cd $REPO_FOLDER/app
echo now into the app file

echo npm install
npm install
echo npm install done

# Stop any existing pm2 processes
echo stopping any running pm2 processes...
pm2 stop all

echo starting the app with pm2...
pm2 start app.js
echo app started!

# Setup Nginx reverse proxy
echo "Setting up Nginx reverse proxy..."
sudo sed -i 's|try_files \$uri \$uri/ =404;|proxy_pass http://localhost:3000;|' /etc/nginx/sites-available/default
echo Done!

echo Restarting Nginx...
sudo systemctl restart nginx
echo Nginx restarted!

# Optional: Check the status of pm2 processes
pm2 list
```
---
-
-
-
---
## **db userdata script**

```bash
#!/bin/bash

# Update the system package list
echo Updating package list...
sudo apt-get update -y
echo Done!

# Upgrade all installed packages to their latest versions
echo Upgrading installed packages...
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
echo Done!

echo Installing gnupg and curl...
sudo apt-get install gnupg curl -y
echo Done!

# Download and add MongoDB GPG key for package verification
echo Adding MongoDB GPG key...
sudo rm -f /usr/share/keyrings/mongodb-server-7.0.gpg # Remove key if one exists 
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg --yes -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor #the --yes will be useful for reruns
echo Done!

# Add MongoDB repository to the sources list
echo Adding MongoDB repository to sources list...
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
echo Done!

# Update package list again to include the newly added MongoDB repository
echo Updating package list with MongoDB repository...
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y
echo Done!

# Install MongoDB version 7.0.6 and specific associated packages non-interactively
echo Installing MongoDB and related packages...
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    mongodb-org=7.0.6 \
    mongodb-org-database=7.0.6 \
    mongodb-org-server=7.0.6 \
    mongodb-org-shell=7.0.6 \
    mongodb-org-mongos=7.0.6
echo Done!

# Start MongoDB service immediately
echo Starting MongoDB service...
sudo systemctl start mongod
echo Done!

# Enable MongoDB service to start on boot
echo Enabling MongoDB service to start on boot...
sudo systemctl enable mongod
echo Done!

# Modify MongoDB configuration to allow remote connections
echo Configuring MongoDB to allow remote connections...
sudo sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
echo Done!

# Restart MongoDB service to apply configurations
echo Restarting MongoDB service...
sudo systemctl start mongod
echo Done!
```

## How to create image

1. Select **Capture Image** on the VM of choice's **Overview**.
2. Under **Instance details**, Select **No, capture only a managed image**.
3. Enable **Automatically delete this virtual machine after creating the image**.
4. Name image appropriately.
5. **Important** Run `sudo waagent -deprovision+user` inside our DB SSH to remove delete information we no longer need, then return to Azure window.
6. Add tags.
7. Review, then create.

## script to rerun app vm from image 

- script needs to be different cause we only need to restart the node app and not install all the dependencies

```bash
#!/bin/bash
 
#Set MongoDB connecting string
export DB_HOST="mongodb://10.0.3.4:27017"  # IMPORTANT CHANGE THIS IF NOT THE SAME DB IP
 
# CD into app directory
echo "Change directory to app"
cd repo/app
echo "In app directory"
 
# Stop all existing pm2 processes
pm2 stop all
 
# Start app
echo "start"
pm2 start app.js
echo "App started with pm2"
```