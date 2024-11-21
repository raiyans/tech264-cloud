#!/bin/bash
# mysql db set up

# Exit immediately if a command exits with a non-zero status used for testing stage
# set -e

# fill in variables yourself
PAT_TOKEN="insert yourself from github"

# Variables
DB_NAME="library" # mysql db name
DB_USER="root"    # mysql db user
DB_PASS="root"    # Replace with a secure password for mysql


echo "Updating system packages..."
export DEBIAN_FRONTEND=noninteractive
sudo apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
echo "Finished system packages update"

echo "Installing MySQL Server..."
sudo DEBIAN_FRONTEND=noninteractive apt install -y mysql-server
echo "Finished installing MySQL"

echo "Starting and enabling MySQL service..."
sudo systemctl start mysql
sudo systemctl enable mysql
echo "Finished enabling mysql"

echo "Configuring MySQL for remote access..."
sudo sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
echo "Finished binding ip adress to internet"

echo "Setting up MySQL database and user..."
sudo mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
MYSQL_SCRIPT
echo "Finished setting user and pass with privledge"

echo "Downloading library.sql file..."
curl -H "Authorization: token $PAT_TOKEN" -o library.sql https://raw.githubusercontent.com/raiyans/library-java17-mysql-app/main/library.sql
echo "finished trying to dl library.sql file..."

echo "Seeding the database..."
sudo mysql -u $DB_USER -p$DB_PASS $DB_NAME < library.sql
echo "Database seeded successfully."

echo "MySQL Database VM setup is complete."
echo "Please ensure this VM's firewall allows access to MySQL on port 3306."
