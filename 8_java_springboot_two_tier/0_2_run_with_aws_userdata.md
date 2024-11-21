# Stage 3 - run app and on aws

## Instruction overview and deliverables

1.  Deploy the app and database on AWS or Azure using Virtual Machines. Automate it via Bash provision scripts that work in user data.
2. Bash provision scripts for app and database VMs that runs in user data

## Steps to set up db vm on aws

1. Launch AWS instance and name appropriately. [refresher](/2_aws_practical/0_two_tier_deploy_with_1_subnet.md) to set up vm.
2. Settings I used  **Ubuntu Server 22.04 LTS (HVM), SSD Volume Type**,  **t2.micro**, whatever Key pair you need, Create Security group allowing inbound **SSH** & **custom tcp** for **db port 3306**.
![sg group](/images/SG-db-vm.png)
3. Connect to terminal 

## Steps to set up app vm on aws

1. Launch AWS instance and name appropriately. [refresher](/2_aws_practical/0_two_tier_deploy_with_1_subnet.md) to set up vm.
2. Settings I used  **Ubuntu Server 22.04 LTS (HVM), SSD Volume Type**,  **t2.micro**, whatever Key pair you need, Create Security group allowing inbound **SSH** & **Http**.
![sg group](/images/java-sg-app.png)
3. Connect to terminal 

## Steps to set up Db vm to be ready 

1. Tried to run each command individually and kept each succesful one on a bash script
2. `nano prov-db.sh` and write your script like the one below
* [bash script](/script_reference/8_2_java_db_script.sh)
``` bash 
#!/bin/bash
# mysql db set up
# Exit immediately if a command exits with a non-zero status used for testing stage
# Uncomment `set -e` during testing to stop execution on errors
# set -e

# fill in variables yourself
PAT_TOKEN="insert yourself from github"
# Variables
DB_NAME="library" # The name of the MySQL database to create
DB_USER="root"    # The username for the MySQL user
DB_PASS="root"    # The password for the MySQL user; replace this with a secure password

echo "Updating system packages..."
# Setting non-interactive frontend to avoid prompts during updates
export DEBIAN_FRONTEND=noninteractive
# Updating the package list
sudo apt update -y
# Upgrading installed packages to their latest versions
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
echo "Finished system packages update"

echo "Installing MySQL Server..."
# Installing the MySQL server package
sudo DEBIAN_FRONTEND=noninteractive apt install -y mysql-server
echo "Finished installing MySQL"

echo "Starting and enabling MySQL service..."
# Starting the MySQL service
sudo systemctl start mysql
# Enabling MySQL to start on system boot
sudo systemctl enable mysql
echo "Finished enabling mysql"

echo "Configuring MySQL for remote access..."
# Updating the MySQL configuration to allow remote connections by replacing the bind address
sudo sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
# Restarting MySQL to apply the configuration changes
sudo systemctl restart mysql
echo "Finished binding IP address to internet"

echo "Setting up MySQL database and user..."
# Running a MySQL script to:
# - Create the database if it doesn't exist
# - Create a user with the specified credentials if it doesn't exist
# - Grant the user full privileges on the specified database
sudo mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES; # Apply privilege changes immediately
MYSQL_SCRIPT
echo "Finished setting user and pass with privilege"

echo "Downloading library.sql file..."
# Using curl to download the `library.sql` file from the GitHub repository
# The authorization header is needed for private repositories
curl -H "Authorization: token $PAT_TOKEN" -o library.sql https://raw.githubusercontent.com/raiyans/library-java17-mysql-app/main/library.sql
echo "Finished trying to download library.sql file..."

echo "Seeding the database..."
# Importing the contents of `library.sql` into the specified database
sudo mysql -u $DB_USER -p$DB_PASS $DB_NAME < library.sql
echo "Database seeded successfully."

echo "MySQL Database VM setup is complete."
echo "Please ensure this VM's firewall allows access to MySQL on port 3306."
```
3. Give permissions `chmod +x prov-db.sh` and the run `./prov.db`


## Steps to set up App vm to connect 

1. Tried to run each command individually and kept each succesful one on a bash script
2. `nano prov-db.sh` and write your script like the one below
* [bash script](/script_reference/8_2_java_app_script.sh)
* make sure to find out your db private ip from before
``` bash 
#!/bin/bash
# java spring boot app set up

# Exit immediately if a command exits with a non-zero status
# Uncomment `set -e` during testing to stop execution on errors
# set -e

# Variables you need to fill in 
PAT_TOKEN="insert yourself"  # Personal Access Token (replace with your actual token)
DB_HOST="172.31.54.196"      # Replace with the IP of the database VM

# Variables
REPO_URL="https://raiyans:$PAT_TOKEN@github.com/raiyans/library-java17-mysql-app.git" # Repository URL with PAT for authentication
APP_DIR="repo"              # Directory name for the cloned repository
DB_PORT=3306                # MySQL database port
DB_NAME="library"           # Name of the database
DB_USER="root"              # MySQL user
DB_PASS="root"              # MySQL password (use a secure password)

echo "Updating system packages..."
# Set non-interactive mode for apt to prevent prompts during updates
export DEBIAN_FRONTEND=noninteractive
# Update package lists to ensure the latest versions of available packages
sudo apt update -y
# Upgrade all installed packages to the latest versions
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y 
echo "Finished system update"

echo "Installing required packages..."
# Install Java JDK 17, Maven, and Git, which are required to run the Spring Boot application
sudo DEBIAN_FRONTEND=noninteractive apt install -y openjdk-17-jdk maven git
echo "Finished all 3rd packages installs"

echo "Cloning the repository..."
# Clone the GitHub repository into the specified directory
git clone "$REPO_URL" $APP_DIR
echo "Finished git clone"

echo "Start Configuring application.properties File"
# Create the Spring Boot application.properties file with database connection details
cat <<EOL > "/home/ubuntu/$APP_DIR/LibraryProject2/src/main/resources/application.properties"
spring.datasource.url=jdbc:mysql://${DB_HOST}:${DB_PORT}/${DB_NAME}  # URL for the MySQL database
spring.datasource.username=${DB_USER}                              # MySQL username
spring.datasource.password=${DB_PASS}                              # MySQL password
spring.jpa.hibernate.ddl-auto=update                               # Hibernate configuration to update schema automatically
server.port=8008                                                   # Server will run on port 8008
EOL

echo "Building and running the application..."
# Change directory to the Spring Boot project folder
cd "/home/ubuntu/$APP_DIR/LibraryProject2"
# Use Maven to build and run the Spring Boot application
mvn spring-boot:run

echo "Application is running at http://$(hostname -I | awk '{print $1}'):8008"
# Print the application URL using the current hostname's private IP
```
3. Give permissions `chmod +x prov-db.sh` and the run `./prov-app.sh`

## Check your provision scripts run correctly on new vms 

1. follow the steps above on fresh vm and make sure it works first time 

## How to make with UserData

1. Create db vm and run db userdata first
![user data](/images/java-userdata.png)
2. Update your app userdata with db ip address 
3. results:
![user data](/images/java-frontpage.png)