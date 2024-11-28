# Stage 5 - Kubernetes Deployment on EC2 with Nginx Reverse Proxy
- [Stage 5 - Kubernetes Deployment on EC2 with Nginx Reverse Proxy](#stage-5---kubernetes-deployment-on-ec2-with-nginx-reverse-proxy)
  - [Instruction overview and deliverables](#instruction-overview-and-deliverables)
  - [Overview](#overview)
  - [Steps to Develop Kubernetes Definitions Locally](#steps-to-develop-kubernetes-definitions-locally)
    - [Prerequisites](#prerequisites)
    - [Step 1: Create the ConfigMap](#step-1-create-the-configmap)
    - [Step 2: Set Up Persistent Storage](#step-2-set-up-persistent-storage)
    - [Step 3: Deploy the MySQL Database](#step-3-deploy-the-mysql-database)
    - [Step 4: Deploy the Spring Application](#step-4-deploy-the-spring-application)
    - [Step 5: Test the Application](#step-5-test-the-application)
    - [Access the Application](#access-the-application)
    - [Verify Database Connection](#verify-database-connection)
  - [Debugging](#debugging)
    - [Check Logs](#check-logs)
    - [Describe Resources](#describe-resources)
    - [Troubleshooting](#troubleshooting)
    - [Clean Up Resources (Optional)](#clean-up-resources-optional)
  - [K8 Files Finished](#k8-files-finished)
  - [Steps Taken to deploy on ec2](#steps-taken-to-deploy-on-ec2)
    - [1. Update and Upgrade System Packages](#1-update-and-upgrade-system-packages)
    - [2. Install Dependencies](#2-install-dependencies)
    - [3. Install Nginx](#3-install-nginx)
    - [4. Install Docker](#4-install-docker)
    - [5. Install `kubectl`](#5-install-kubectl)
    - [6. Install Minikube](#6-install-minikube)
    - [7. Start Minikube](#7-start-minikube)
    - [8. Clone Repository and Apply Kubernetes Configuration](#8-clone-repository-and-apply-kubernetes-configuration)
    - [9. Retrieve Minikube IP](#9-retrieve-minikube-ip)
    - [10. Retrieve EC2 Public IP](#10-retrieve-ec2-public-ip)
    - [11. Configure Nginx](#11-configure-nginx)
    - [12. Test and Reload Nginx Configuration](#12-test-and-reload-nginx-configuration)
    - [13. Verify Deployment](#13-verify-deployment)
  - [Ec2 Provision script](#ec2-provision-script)
  - [Deliverables](#deliverables)

## Instruction overview and deliverables

1. Deploy the app and database on AWS or Azure using Kubernetes (Minikube) running on a Virtual Machine. Automate it via Bash provision scripts that work in user data. The Bash scripts could deploy on Kubernetes via applying YAML definition files or (optional) using a Helm chart. (1-2 days)
2. For Stage 5 above:
      - Bash provision script for a single VM that runs in user data, but provisions and deploys the app and database using Kubernetes (and optionally Helm) on the one machine

      - Kubernetes-related files
        * YAML definition/configuration files
        * (Optional) Helm chart and values YAML files

## Overview

This stage focuses on deploying a containerized application and database using Kubernetes on an EC2 instance. The deployment includes setting up an Nginx reverse proxy to expose the application on the public IP of the EC2 instance.

---
## Steps to Develop Kubernetes Definitions Locally
- run minikube or docker desktop and start applying difffernt components
  
Follow these steps to create and deploy the Kubernetes resources defined in your YAML files.

### Prerequisites
1. **Install Kubernetes**:
   - Set up a local Kubernetes cluster using tools like Minikube, Kind, or Docker Desktop.
2. **Install kubectl**:
   - Ensure 'kubectl' is installed and configured to connect to your local Kubernetes cluster.
3. **Validate Docker Images**:
   - Ensure the 'mysql:8.0' image and 'raiyans/library-app:v2' image are available or accessible on your machine.

---


### Step 1: Create the ConfigMap
- Apply the 'ConfigMap' for database seeding:
``` bash
  kubectl apply -f <path-to-configmap-file>.yaml
``` 
- Verify creation:
``` bash
  kubectl get configmap database-seed
``` 

### Step 2: Set Up Persistent Storage
- Apply the 'PersistentVolumeClaim' for database data:
``` bash
  kubectl apply -f <path-to-pvc-file>.yaml
``` 
- Verify the PVC:
``` bash
  kubectl get pvc db-data-pvc
``` 

### Step 3: Deploy the MySQL Database
- Apply the database deployment:
``` bash
  kubectl apply -f <path-to-database-deployment-file>.yaml
``` 
- Check the deployment and Pod:
``` bash
  kubectl get deployments spring-database
  kubectl get pods -l app=spring-database
``` 
- Expose the database as a service:
``` bash
  kubectl apply -f <path-to-database-service-file>.yaml
``` 
- Verify the service:
``` bash
  kubectl get service spring-database
``` 

### Step 4: Deploy the Spring Application
- Apply the application deployment:
``` bash
  kubectl apply -f <path-to-application-deployment-file>.yaml
``` 
- Check the deployment and Pod:
``` bash
  kubectl get deployments spring-sparta-app-deployment
  kubectl get pods -l app=spring-sparta-app
``` 
- Expose the application as a service:
``` bash
  kubectl apply -f <path-to-application-service-file>.yaml
``` 
- Verify the service:
``` bash
  kubectl get service spring-sparta-app-service
``` 

---

### Step 5: Test the Application

### Access the Application
1. Find the Node IP:
``` bash
   kubectl cluster-info
``` 
2. Access the application via the NodePort:
   - URL: 'http://<Node-IP>:30002'

### Verify Database Connection
1. Check if the application connects to the MySQL database properly.
2. Validate seeded data via the application.

---

## Debugging 

### Check Logs
- MySQL Pod logs:
``` bash
  kubectl logs -l app=spring-database
``` 
- Spring Application logs:
``` bash
  kubectl logs -l app=spring-sparta-app
``` 

### Describe Resources
- Describe Pods:
``` bash
  kubectl describe pod -l app=spring-database
  kubectl describe pod -l app=spring-sparta-app
``` 

### Troubleshooting
- Ensure the MySQL container initializes with the seeded data from the ConfigMap.
- Verify connectivity between the application and the database.

---

### Clean Up Resources (Optional)
- Delete all resources:
``` bash
  kubectl delete -f <path-to-yaml-files>
``` 

---
## K8 Files Finished
- [k8 db](/script_reference/8_4_k8_db_all_definitions.yml)
- [k8 app](/script_reference/8_4_k8_app_all_definitions.yml)

## Steps Taken to deploy on ec2

### 1. Update and Upgrade System Packages
Ensure the system is up-to-date:
``` bash
sudo apt-get update -y && sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
```
### 2. Install Dependencies
Install required packages for managing repositories and certificates:
``` bash
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates curl software-properties-common
```
### 3. Install Nginx
Install and configure Nginx for reverse proxy:
``` bash
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nginx
```
### 4. Install Docker
Add Docker’s GPG key and install Docker:
``` bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
```

### 5. Install `kubectl`
Download and install the `kubectl` binary:
``` bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl
rm kubectl

```
### 6. Install Minikube
Download and install Minikube:
``` bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64
```
### 7. Start Minikube
Start Minikube with the Docker driver:
``` bash
sudo minikube start --driver=docker --listen-address=0.0.0.0 --force
```
### 8. Clone Repository and Apply Kubernetes Configuration
Clone the application repository and deploy Kubernetes resources:
``` bash
git clone https://github.com/raiyans/k8-sparta-spring-app-db.git repo
cd repo
sudo kubectl apply -f db-all.yml
sleep 30s
sudo kubectl apply -f app-all.yml
```
### 9. Retrieve Minikube IP
Get the Minikube cluster IP:
``` bash
MINIKUBE_IP=$(sudo minikube ip)
echo "Minikube IP is $MINIKUBE_IP"
```
### 10. Retrieve EC2 Public IP
Retrieve the public IP of the EC2 instance:
``` bash
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
EC2_PUBLIC_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4)
echo "EC2 Public IP is $EC2_PUBLIC_IP"
```
### 11. Configure Nginx
Update Nginx configuration to use the EC2 public IP and Minikube service:
``` bash
sudo tee /etc/nginx/sites-available/default <<EOL
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name $EC2_PUBLIC_IP;

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    location / {
        proxy_pass http://$MINIKUBE_IP:30002;
    }
}
EOL
```
### 12. Test and Reload Nginx Configuration
Test the Nginx configuration:
``` bash
sudo nginx -t
sudo systemctl reload nginx
```
### 13. Verify Deployment
Check Kubernetes resources to ensure the application and database are running:
``` bash
kubectl get all
```
---
## Ec2 Provision script
- [bash script](/script_reference/8_4_minik8s_app_db.sh)

``` bash
#!/bin/bash

# Variables
NGINX_CONFIG="/etc/nginx/sites-available/default"
MINIKUBE_IP=""
MINIKUBE_NODEPORT=30002

echo "Updating system packages..."
sudo apt-get update -y && sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

echo "Installing dependencies..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates curl software-properties-common
echo "Installing Nginx..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nginx

echo "Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io
echo "Ending dokcer stage"

echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl
rm kubectl

echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

echo "Starting Minikube with Docker driver..."
sudo minikube start --driver=docker --listen-address=0.0.0.0 --force

git clone https://github.com/raiyans/k8-sparta-spring-app-db.git repo
cd repo 

echo "Applying Kubernetes configuration files..."
sudo kubectl apply -f db-all.yml
sleep 30s
sudo kubectl apply -f app-all.yml

# Retrieve Minikube IP
MINIKUBE_IP=$(sudo minikube ip)
echo "Minikube IP is $MINIKUBE_IP"

# Retrieve the EC2 public IP
echo "Configuring EC2 public ip..."
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
EC2_PUBLIC_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4)
echo the public ip is $EC2_PUBLIC_IP

echo "Configuring Nginx..."
sudo tee $NGINX_CONFIG <<EOL
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name $EC2_PUBLIC_IP;

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    location / {
        proxy_pass http://$MINIKUBE_IP:$MINIKUBE_NODEPORT;
    }
}
EOL

echo "Testing Nginx configuration..."
sudo nginx -t

echo "Reloading Nginx..."
sudo systemctl reload nginx

echo "Setup complete! Your application is available on this server's public IP."
```

## Deliverables

- **Bash Script**: Automates the installation and configuration of all components.
- **Kubernetes Manifests**: YAML files for deploying the application and database.
- **Nginx Reverse Proxy**: Configured to expose the application using the EC2 public IP.

Your application is now accessible via the EC2 instance's public IP on port 80.