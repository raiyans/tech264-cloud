# Code Along

**Before starting lets delete vm from previous works**
## Deleting Your Virtual Machine
1. Navigate to overview.
2. Find your resource group.
3. Filter your name. You will see multiple items appear.
4. Tick `resourcegroupname-name-vmname`
5. Tick `resourcegroupname-vmname-ip`
6. Tick `resourcegroupname-vmname-nsg`
7. Tick `resourcegroupname-name-networkinterface`
8. Tick `resourcegroupname-name-Disk`
9. Locate **delete**. Avoid deleting the **resource group**.
10. Tick "Apply force delete" just to be safe.
11. Enter "delete" in the input box and click **delete**.
12. Select **delete** once more to confirm **deletion**.
 
We leave the Virtual Network and SSH Key as they can be reuse
## How to run script with no user input
- Always test your commands manually first.
- `nano provision.sh` - to create a new file called provision.sh
  - Alternatively you can copy provision script from local with `scp -i ~/.ssh/tech264-raiyan-az-key -r "C:\Users\Raiyan\provision.sh" adminuser@4.234.159.32:~/`
- `#!/bin/bash` - shows location of bash script required to run commands (called "shabang").
``` bash
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


```
- `chmod +x provision.sh` - add execute permissions to your file
- `./provision.sh` - to execute your script
- to run without any logs `./provision.sh > provision.log 2>&1 &`
   - `provision.log`: Redirects standard output (stdout) to provision.log.
   - `2>&1`: Redirects standard error (stderr) to the same log file.
   - `&`: Puts the script in the background.
- simple way to run in background is to run `npm start &` in script

## how to copy node app folder from local to vm with ssh
1. go to your local machine and identify folder you want to push
2. then run `scp -i ~/.ssh/tech264-raiyan-az-key -r "C:\Users\Raiyan\Downloads\app" adminuser@20.0.184.151:~/`
    * scp
    * -i
    * path destination
2. Better Alternative is using rsync 
   * `sudo apt update`
   * `sudo apt install rsync`
   * Then run `rsync -avz -e "ssh -i ~/.ssh/tech264-raiyan-az-key" /path/to/local/folder/ adminuser@20.0.184.151:/path/to/remote/folder/`

3. then cd into folder and then run `npm install` and `npm start` or `node app.js`

## Database vm

1. choose your private subnet when creating db vm (no outside internet access for now)
create the vm and name it tech-264-raiyan-run-db
ports open, not http need ssh only
personal key 

2. sudo apt update and upgrade
* mongodb to install
3. get the gpg package
`sudo apt-get install gnupg curl`
checks if package is aunthentic  
```bash
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
   ```

4. create a sources list file of the 
    ``` bash
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
    ```

   * Do another update `sudo apt-get update -y`

1. install the mongodb server 
    ``` sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 mongodb-org-server=7.0.6 mongodb-mongosh=2.1.5 mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6 ```


6. check if mongo is active
`sudo systemctl status mongod`

## Start mongodb
1. edit config mongo file
 `sudo nano /etc/mongod.conf`
 change bind ip from 127.0.0.0 to 0.0.0.0 to accept connections from any ip address

1. restart to let it start back up everytime vm restarts
`sudo systemctl restart mongod`
`sudo systemctl is-enabled mongod`
`sudo systemctl enable mongod`

## db script with all the doing the manual steps

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

## switch to the app vm
1. go cd into app
* use private ip first if available before using public ip

2. we will make an env variable for the db string to connect to 
`export DB_HOST=mongodb://10.0.3.4:27017/posts`
3. check env var is set
`printenv DB_HOST`

4. run npm install and you should see database is seeded in the logs

now you can see the posts sourced from the db on the node app with the public ip and port 3000 for the node app vm
http://20.0.184.151:3000/posts


## Reverse proxy

1. check nginx is running `sudo systemctl status nginx`
2. `sudo nano /etc/nginx/sites-available/default` go into this confgi file
3. edit file 
4. replace text of 
```
    location / {
        try_files $uri $uri/ =404;
    }
```
with
```
    location / {
        # Forward all requests to the Node.js app running on port 3000
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
```
5. `sudo systemctl restart nginx` restart and check the url can be accessed without a port number included


## misc

* sed command for automate string edit on mongodb
* sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf
  - sudo: Runs the command as a superuser (required to edit system files).
  - sed: The stream editor command used to perform text substitution.
  - -i: In-place editing, meaning the changes will be applied directly to the file.
  - 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/': This is the substitution pattern:
    - s/old_text/new_text/ replaces bindIp: 127.0.0.1 with bindIp: 0.0.0.0.
  - /etc/mongod.conf: Path to the MongoDB configuration file.