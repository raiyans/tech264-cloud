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
  - [Conclusion](#conclusion)
- [automate reverse proxy into our bash script](#automate-reverse-proxy-into-our-bash-script)
  - [**To look for logs when user data worked**](#to-look-for-logs-when-user-data-worked)

## Task: How many services can use a port?
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
Updated Script:
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


# automate reverse proxy into our bash script 

```bash
# Nginx configuration changes

NGINX_CONF="/etc/nginx/sites-available/default"
BACKUP_CONF="/etc/nginx/sites-available/default.bak"

echo Backing up Nginx default config...
sudo cp $NGINX_CONF $BACKUP_CONF
echo Backup done.

echo Configuring Nginx for reverse proxy...
# Use sed to configure Nginx to forward port 80 to Node.js app running on port 3000
sudo sed -i '/server_name _;/a \\n\tlocation / {\n\t\tproxy_pass http://localhost:3000;\n\t\tproxy_set_header Host $host;\n\t\tproxy_set_header X-Real-IP $remote_addr;\n\t\tproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n\t\tproxy_set_header X-Forwarded-Proto $scheme;\n\t}\n' $NGINX_CONF
echo Nginx configuration updated.

echo Restarting Nginx...
sudo systemctl restart nginx
echo Nginx restarted.

echo Check if Nginx is running...
sudo systemctl status nginx | grep "active (running)"
echo Done! Now test in the browser without :3000.
```

## **To look for logs when user data worked**

- you can run `sudo systemctl status mongod` to see mongodb is running
- you can run `sudo cat /var/log/cloud-init-output.log` to see logs of userdata running
- you can run `cat /etc/mongod.conf | grep bindIp`