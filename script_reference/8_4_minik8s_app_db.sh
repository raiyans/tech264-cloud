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
