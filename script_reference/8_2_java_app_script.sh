#!/bin/bash
# java spring boot app set up

# Exit immediately if a command exits with a non-zero status used for testing stage
# set -e

# Variables you need to fill in 
PAT_TOKEN="insert yourself"
DB_HOST="172.31.54.196"  # Replace with the IP of the db VM

# Variables
REPO_URL="https://raiyans:$PAT_TOKEN@github.com/raiyans/library-java17-mysql-app.git"
APP_DIR="repo"
DB_PORT=3306      # mysql port number
DB_NAME="library" # mysql db name
DB_USER="root"    # mysql db user
DB_PASS="root"    # Replace with the mysql db password used in the db VM

echo "Updating system packages..."
export DEBIAN_FRONTEND=noninteractive
sudo apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y 
echo "Finished system update"

echo "Installing required packages..."
sudo DEBIAN_FRONTEND=noninteractive apt install -y openjdk-17-jdk maven git
echo "Finished all 3rd packages installs"

echo "Cloning the repository..."
git clone "$REPO_URL" $APP_DIR
echo "Finished git clone"

echo "Start Configuring application.properties File"
cat <<EOL > "/home/ubuntu/$APP_DIR/LibraryProject2/src/main/resources/application.properties"
spring.datasource.url=jdbc:mysql://${DB_HOST}:${DB_PORT}/${DB_NAME}
spring.datasource.username=${DB_USER}
spring.datasource.password=${DB_PASS}
spring.jpa.hibernate.ddl-auto=update
server.port=8008
EOL

echo "Building and running the application..."
cd "/home/ubuntu/$APP_DIR/LibraryProject2"
mvn spring-boot:run

echo "Application is running at http://$(hostname -I | awk '{print $1}'):8008"
