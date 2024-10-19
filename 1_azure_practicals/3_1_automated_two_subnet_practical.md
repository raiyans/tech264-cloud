- [automate reverse proxy into our bash script](#automate-reverse-proxy-into-our-bash-script)
  - [Key Things to Know About User Data:](#key-things-to-know-about-user-data)
  - [**To look for logs when user data worked**](#to-look-for-logs-when-user-data-worked)
- [Levels of Automation: Deploying our app on the cloud.](#levels-of-automation-deploying-our-app-on-the-cloud)
    - [1. Manual Deployment (No Automation)](#1-manual-deployment-no-automation)
    - [2. Scripted Deployment (Basic Automation)](#2-scripted-deployment-basic-automation)
    - [3. Infrastructure as Code (Full Automation)](#3-infrastructure-as-code-full-automation)
    - [4. Continuous Deployment (Full Automation + Continuous Integration)](#4-continuous-deployment-full-automation--continuous-integration)
- [Images:](#images)
  - [How You Use Images:](#how-you-use-images)
- [Launch app+db Image](#launch-appdb-image)
  - [**app userdata script**](#app-userdata-script)
  - [**db userdata script**](#db-userdata-script)
  - [How to create image](#how-to-create-image)
  - [script to rerun app vm from image](#script-to-rerun-app-vm-from-image)

# automate reverse proxy into our bash script 
- [Initialize Nginx Configs](/script_reference/3_1_initialize_nginx_configs_script.sh)
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

## Key Things to Know About User Data:
1. The Script Runs as Root:
   * The script runs with **root** (admin) privileges, so you don’t need to use `sudo` for commands in your script.
   * It starts from the **root directory** (`/`), which is the top of the file system. So, when you clone a repository (like from GitHub), make sure to specify where you want it to go.

2. Make Sure Your VM Can Be Accessed:
   * Your virtual machine’s Network Security Group (NSG) controls what traffic can come in or go out of the VM. If you want people to access your app on the web, you need to make sure your NSG allows HTTP (port 80) and/or HTTPS (port 443) traffic.
   * If this isn't set, people won’t be able to reach your app in their web browser.
  
**How to allow HTTP:**
  * Go to the NSG settings for your VM and make sure port 80 (for HTTP) is open for inbound traffic.

3. Setting Up a Reverse Proxy (Nginx):
   * When you're hosting a web app (like a Node.js app), you often use a **reverse proxy**. 
     * This is a program (like Nginx) that takes web traffic coming into your VM and forwards it to the right place (like your app running on port 3000).
   * You can **automate setting up a reverse proxy** in your User Data script, so you don’t have to manually configure it every time.

4. Cloning Your Code:
   * If your app’s code is on GitHub or another repository, you’ll want to **download (clone) it onto your VM**. You can do this as part of your User Data script.

5. One-Time Setup:
   * Since User Data only runs once (right after the VM is created), make sure your script is complete and works correctly. 
     * If there are errors, you’ll need to manually fix them later, so it’s good to test the script in small parts to ensure everything works.


## **To look for logs when user data worked**

- you can run `sudo systemctl status mongod` to see mongodb is running
- you can run `sudo cat /var/log/cloud-init-output.log` to see logs of userdata running
- you can run `cat /etc/mongod.conf | grep bindIp`

# Levels of Automation: Deploying our app on the cloud.
1. `Manual Deployment`: Everything is done manually, time-consuming and prone to errors.
2. `Scripted Deployment`: Use scripts to automate setup tasks, faster but still involves some manual steps.
3. `Infrastructure as Code` (IaC): Automate the creation of infrastructure and deployment of apps, highly scalable and replicable.
4. `Continuous Deployment` (CI/CD): Fully automated deployment and updates whenever changes are pushed to the codebase, enabling seamless updates and scaling.

Each level brings more efficiency, scalability, and consistency to your deployment process, with the final goal of having a fully automated pipeline that handles everything from infrastructure to app updates with minimal manual intervention.

### 1. Manual Deployment (No Automation)
At this level, the deployment process is done entirely by hand. This involves manually creating a virtual machine (VM), installing required software, and configuring the environment step-by-step.

    Steps:
    * Create a VM in a cloud provider (like Azure, AWS, or Google Cloud) manually.
    * SSH into the VM to install software (e.g., Nginx, Node.js, MongoDB).
    * Manually download your application code (e.g., clone from GitHub).
    * Set up the environment variables, configure the reverse proxy (Nginx), and start your application.

Pros:
* Simple and easy to understand for beginners.

Cons:
* Time-consuming and error-prone.
* Inconsistent deployments because steps might be missed or done incorrectly.
* Not scalable—each new VM needs to be set up from scratch.    


### 2. Scripted Deployment (Basic Automation)
   * At this level, you automate repetitive tasks by writing scripts (e.g., Bash scripts) that can install the necessary software, clone your app, and set it up. 
   * Instead of doing everything manually, you simply run a script that executes all these commands for you.

   Steps:
   * Write a script that performs all the necessary installation and configuration steps (installing software, setting up environment variables, etc.).
   * Run this script manually after creating a VM.

Pros:
* Faster than manual deployment.
* Reduces the chances of human error.

Cons:
* The script must be run manually (or provided during VM creation with a feature like User Data).
* Still needs some manual intervention to manage different VMs.


### 3. Infrastructure as Code (Full Automation)
* At this level, you automate the entire process of creating the infrastructure (VMs, networks, security groups) and deploying the app. 
* Infrastructure as Code (IaC) tools like Terraform or Azure Resource Manager (ARM) templates are used to define and provision the infrastructure using configuration files. 
* This way, everything is automated—from creating the VM to deploying the application.

Steps:
* Use an IaC tool (like Terraform, AWS CloudFormation, or ARM templates) to define the cloud resources required for your app (VMs, load balancers, databases, etc.).
* Write deployment scripts to automate the configuration and deployment of the app on the provisioned VMs.
* Deploy the entire infrastructure and application automatically with one command.

Pros:
* Full automation, including infrastructure provisioning.
* Can easily replicate the entire setup in multiple environments (dev, test, prod) with consistent results.
* Scalable—automatically creates and deploys VMs as needed.

Cons:
* Requires learning IaC tools.
* More complex to set up initially, but pays off in the long run.


### 4. Continuous Deployment (Full Automation + Continuous Integration)
* At this level, you not only automate infrastructure and deployment but also integrate it with a CI/CD pipeline. 
* This allows your application to be automatically deployed and updated whenever you push changes to your code repository (e.g., GitHub, GitLab).

Steps:
* Set up a CI/CD pipeline (e.g., with Jenkins, GitHub Actions, or Azure DevOps) to automatically build, test, and deploy your application whenever changes are pushed to the repository.
* Use IaC tools to automatically provision infrastructure and deploy the app on it.
* Ensure that new code changes trigger redeployment, making the process seamless.

Pros:
* The most advanced and efficient deployment process.
* Full automation from code push to deployment.
* Enables continuous updates and scaling without manual intervention.

Cons:
* The most complex to set up initially.
* Requires knowledge of CI/CD tools and processes.


# Images: 
* We've been using Ubuntu Pro 22 (a market place image). 
* We've been using a market place image to create our Vms.
  * The image determines everything thats going to go on the disk.
  * Then we prepared the VM to run the app. 
  * Create a custom image, used to create an app VM with everything already installed. 
  
"requires Plan information": you can't do this unless your provide information about the origihnal market place image you used. This is because you need to give credit: sometimes they may need to charge you. You need to provide that information when you create your VM.
  * they want to have info on the original market place image that you included. 
  * To solve this: don't use the one from ubuntu, we'll be using a custom marketplace image that Ramon has set up. `ramon-official-ubuntu2204-clean-image`

## How You Use Images:
* When you want to create a VM, you **select an image** from Azure's image gallery (like choosing "Ubuntu 22.04" or "Windows Server 2022").
* Azure **uses that image to build your VM**, meaning the **VM will have** all the **software and configurations from the image**, so you **don’t need to set it up manually**.

**In short, Azure images help you quickly create virtual machines that are ready to use, without having to manually install an operating system or software.**

[link to more images info](/0_research/6_images.md)


# Launch app+db Image
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
- [Initialize App script](/script_reference/3_1_initialize_app_script.sh)
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

- [Initialize DB script](/script_reference/3_1_initialize_db_script.sh)

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

- [Reboot App](/script_reference/3_1_reboot_app.sh)
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