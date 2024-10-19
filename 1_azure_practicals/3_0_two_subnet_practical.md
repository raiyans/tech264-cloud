# App and DB Deployment in Two Subnets
- [App and DB Deployment in Two Subnets](#app-and-db-deployment-in-two-subnets)
  - [How to run script with no user input](#how-to-run-script-with-no-user-input)
  - [how to copy node app folder from local to vm with ssh](#how-to-copy-node-app-folder-from-local-to-vm-with-ssh)
  - [Database vm](#database-vm)
  - [Start mongodb](#start-mongodb)
  - [db script with all the doing the manual steps](#db-script-with-all-the-doing-the-manual-steps)
  - [switch to the app vm](#switch-to-the-app-vm)
  - [Reverse proxy](#reverse-proxy)
    - [Why Create a Reverse Proxy for Your App?](#why-create-a-reverse-proxy-for-your-app)
  - [Misc](#misc)
  - [Research: How many services can use a port?](#research-how-many-services-can-use-a-port)
    - [Objective](#objective)
    - [Step 1: Run the Sparta App](#step-1-run-the-sparta-app)
    - [Step 2: Open a Second Terminal and Run the App](#step-2-open-a-second-terminal-and-run-the-app)
      - [Expected Error](#expected-error)
    - [Explanation of the Error](#explanation-of-the-error)
    - [Step 3: Fixing the Error](#step-3-fixing-the-error)
    - [Option 1: Change the Port Number](#option-1-change-the-port-number)
    - [Option 2: Kill the Existing Process Using Port 3000](#option-2-kill-the-existing-process-using-port-3000)
    - [Step 4: Finding the Process Using Port 3000](#step-4-finding-the-process-using-port-3000)
    - [Linux Command:](#linux-command)
    - [Example Output](#example-output)
    - [Step 5: Killing the Process](#step-5-killing-the-process)
- [Running, Stopping, and Restarting a Node.js App in the Background](#running-stopping-and-restarting-a-nodejs-app-in-the-background)
  - [1. Running the App Using `&` (Background Execution)](#1-running-the-app-using--background-execution)
    - [Command:](#command)
    - [Explanation:](#explanation)
    - [Issues with `&`:](#issues-with-)
  - [2. Running the App Using `pm2`](#2-running-the-app-using-pm2)
    - [Steps to Use `pm2`:](#steps-to-use-pm2)
    - [Benefits of `pm2`:](#benefits-of-pm2)
  - [3. Running the App Using `forever` (Alternative to `pm2`)](#3-running-the-app-using-forever-alternative-to-pm2)
    - [Steps to Use `forever`:](#steps-to-use-forever)
    - [Benefits of `forever`:](#benefits-of-forever)
  - [4. Script Integration with `pm2`](#4-script-integration-with-pm2)
    - [Steps to Modify Your Script to Use `pm2`:](#steps-to-modify-your-script-to-use-pm2)
    - [Updated Script:](#updated-script)
  - [Conclusion](#conclusion)


## How to run script with no user input
- Always test your commands manually first.
- `nano provision.sh` - to create a new file called provision.sh
  - Alternatively you can copy provision script from local with `scp -i ~/.ssh/tech264-raiyan-az-key -r "C:\Users\Raiyan\provision.sh" adminuser@4.234.159.32:~/`
- `#!/bin/bash` - shows location of bash script required to run commands (called "shabang").
- [App script](/script_reference/) below
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
- [DB manual script](/script_reference/3_0_db_script.sh)
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

### Why Create a Reverse Proxy for Your App?
A reverse proxy serves as an intermediary for clients requesting resources from your backend servers (like a Node.js app). In this case, you are setting up Nginx as a reverse proxy to forward incoming requests to your Node.js application running on port 3000, while allowing users to access the app without specifying the port in the URL.


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


## Misc

* sed command for automate string edit on mongodb
* sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf
  - sudo: Runs the command as a superuser (required to edit system files).
  - sed: The stream editor command used to perform text substitution.
  - -i: In-place editing, meaning the changes will be applied directly to the file.
  - 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/': This is the substitution pattern:
    - s/old_text/new_text/ replaces bindIp: 127.0.0.1 with bindIp: 0.0.0.0.
  - /etc/mongod.conf: Path to the MongoDB configuration file.


## Research: How many services can use a port?
### Objective
To demonstrate the behavior of running the Sparta application in two different Git Bash terminals on the same virtual machine (VM) and resolve the resulting error due to port conflicts.
 
### Step 1: Run the Sparta App
1. Open the first **Git Bash** terminal.
2. Navigate to the directory where the Sparta app is located.
3. Run the app using the command:
   ```bash
   npm start
   ```
 
### Step 2: Open a Second Terminal and Run the App
1. Open a second **Git Bash** terminal.
2. Again, navigate to the directory where the Sparta app is located.
3. Attempt to run the app using the same command:
   ```bash
   npm start
   ```
 
#### Expected Error
When you try to run the Sparta app in the second terminal, you will receive an error indicating that port 3000 is already in use. The error message will look something like this:
 
```
Error: listen EADDRINUSE: address already in use ::1:3000
```

### Explanation of the Error
This error occurs because both instances of the Sparta app are trying to bind to the same port (3000). When the first instance is already running and listening on that port, the second instance cannot start.
 
### Step 3: Fixing the Error
To resolve this issue, you have two options:
 
### Option 1: Change the Port Number
1. Open the `server.js` or relevant configuration file of the Sparta app.
2. Change the port number from `3000` to another unused port (e.g., `3001`).
3. Save the changes.
4. Re-run the app in the second terminal using:
   ```bash
   npm start
   ```
 
### Option 2: Kill the Existing Process Using Port 3000
If you want to run the app on port 3000, you can terminate the process currently using that port.
 
### Step 4: Finding the Process Using Port 3000
To find out which process is using port 3000, you can use the following command:
 
### Linux Command:
```bash
lsof -i :3000
```
 
**Explanation:**
- `lsof` lists open files and the corresponding processes.
- `-i :3000` filters the list to show only processes using port 3000.
 
### Example Output
You might see output like this:
```
COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
node    12345 user   23u  IPv6 0x1234      0t0  TCP *:3000 (LISTEN)
```
In this case, the `PID` (Process ID) is `12345`, which you can use to terminate the process.
 
### Step 5: Killing the Process
To terminate the process using port 3000, use the `kill` command followed by the PID:
 
```bash
kill 12345
```
 
**Note:** If the process does not terminate, you can use `kill -9` to forcefully kill it:
```bash
kill -9 12345
```


# Running, Stopping, and Restarting a Node.js App in the Background

This document outlines various ways to run, stop, and restart a Node.js application in the background without using `&` at the end of the command.

## 1. Running the App Using `&` (Background Execution)

### Command:
```bash
node app.js &
```

### Explanation:
Appending `&` runs the Node.js app in the background, allowing the terminal to be free for other commands.

### Issues with `&`:
- **Stopping the App**: Requires manually finding the process ID (PID) and killing it:
  ```bash
  pgrep node  # Find the process ID
  kill <PID>  # Stop the process
  ```
- **Restarting the App**: Requires manually stopping the app and rerunning the command.
- **Crash Handling**: If the app crashes, it will not restart automatically.
- **Not Suitable for Production**: Lacks advanced process management features such as monitoring and automatic restart.

---

## 2. Running the App Using `pm2`

`pm2` is a production-ready process manager for Node.js applications, offering advanced features like process monitoring, automatic restart, and easy process management.

### Steps to Use `pm2`:

1. **Install `pm2`**:
   ```bash
   sudo npm install -g pm2
   ```

2. **Start the App with `pm2`**:
   ```bash
   pm2 start app.js
   ```

3. **Stop the App**:
   ```bash
   pm2 stop app.js
   ```

4. **Restart the App**:
   ```bash
   pm2 restart app.js
   ```

5. **Check App Status**:
   ```bash
   pm2 list
   ```

6. **View Logs**:
   ```bash
   pm2 logs
   ```

7. **Stop All Processes**:
   ```bash
   pm2 stop all
   ```

### Benefits of `pm2`:
- **Automatic Restarts**: The app automatically restarts if it crashes.
- **Process Monitoring**: Displays the status and performance of all running processes.
- **Easy Management**: Provides easy start, stop, and restart commands for processes.

---

## 3. Running the App Using `forever` (Alternative to `pm2`)

`forever` is another process manager that ensures your Node.js applications run continuously, even after a crash.

### Steps to Use `forever`:

1. **Install `forever`**:
   ```bash
   sudo npm install -g forever
   ```

2. **Start the App with `forever`**:
   ```bash
   forever start app.js
   ```

3. **Stop the App**:
   ```bash
   forever stop app.js
   ```

4. **Restart the App**:
   ```bash
   forever restart app.js
   ```

5. **List Running Processes**:
   ```bash
   forever list
   ```

6. **View Logs**:
   ```bash
   forever logs
   ```

### Benefits of `forever`:
- **Persistent Process**: Keeps the app running continuously.
- **Crash Handling**: Automatically restarts the app after a crash.

---

## 4. Script Integration with `pm2`

### Steps to Modify Your Script to Use `pm2`:

1. **Install `pm2` in the Script**:
   Add the following to your script to install `pm2`:
   ```bash
   sudo npm install -g pm2
   ```

2. **Replace `node app.js &` with `pm2`**:
   Use the following command to start your app with `pm2` in your deployment script:
   ```bash
   pm2 start app.js
   ```

3. **Handling Existing Processes**:
   If an app process is already running, `pm2` will throw an error. You can stop all running processes before starting the new one by adding:
   ```bash
   pm2 stop all
   ```

4. **Check App Status**:
   After starting the app with `pm2`, you can check its status with:
   ```bash
   pm2 list
   ```

5. **Accessing the App in the Browser**:
   After running the script, check if the app is accessible via the public IP of your VM. If your reverse proxy is configured correctly, you should be able to access the app without appending `:3000`.

You can modify your deployment script to use pm2 instead of &. Here's an updated version of your script that:

Installs pm2.
Uses pm2 to start the Node.js app.
Stops any running processes before starting a new one.
###  Updated Script:
- [Updated script](/script_reference/3_0_app_final_script.sh)
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

## Conclusion
- The `&` method works for running apps in the background but lacks advanced process management features like automatic restarts and monitoring.
- `pm2` is the recommended method for production environments, offering easy process management, monitoring, and automatic restarts.
- `forever` is another good alternative if you prefer a simpler setup for running Node.js apps continuously.

