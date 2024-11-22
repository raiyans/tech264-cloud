#!/bin/bash

# fill in variables yourself
PAT_TOKEN="insert yourself from github"

# Define variables
REPO_URL="https://raiyans:$PAT_TOKEN@github.com/raiyans/library-java17-mysql-app.git"
APP_DIR="repo"

# Update and install prerequisites
echo "Updating system and installing prerequisites..."
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y git curl apt-transport-https ca-certificates software-properties-common

# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Start and enable Docker service
echo "Starting and enabling Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

# Verify Docker installation
echo "Verifying Docker installation..."
docker --version

# Clone the repository
echo "Cloning the repository..."
git clone "$REPO_URL" "$APP_DIR"
cd "$APP_DIR"

# Start the application with Docker Compose
echo "Starting the application with Docker Compose..."
sudo docker compose down
sudo docker compose up --build -d

# Verify that containers are running
echo "Verifying running containers..."
docker ps
