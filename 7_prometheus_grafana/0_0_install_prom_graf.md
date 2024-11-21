## Create an EC2 Instance with Grafana Installed
 
### Setting up the EC2 instance
1. Set up an EC2 instance using Ubuntu. Ensure **Don't forget** the **security group allows `SSH` and port `3000`.**
2. `sudo apt-get update` and `sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y`.
 
### Install Docker
1. Install Docker: `sudo apt-get install docker.io -y`
2. Start Docker Service: `sudo systemctl start docker`
3. Check docker status: `sudo systemctl status docker`
4. Enable Docker to Start at Boot: `sudo systemctl enable docker`
 
### Pull and run the Grafana Docker Image
1. Pull the Latest Grafana Image: `sudo docker pull grafana/grafana`
2. Run the Container: `sudo docker run -d -p 3000:3000 --name=grafana grafana/grafana`
 
### Go to the Grafana UI
1. Use the EC2 public IP with the port `3000` to access the Grafana UI. The default login details are:
   - **username**: `admin`
   - **password**: `admin`
 
## Create an EC2 Instance with Prometheus Installed
 
### Setting up the EC2 instance
1. Set up an EC2 instance using Ubuntu. Ensure the security group allows `SSH`, `HTTP` and port `9090` (Prometheus uses this port).
2. `sudo apt-get update` and `sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y`.
 
### Install Prometheus and Prometheus Node Exporter and Configure the YAML file
1. Insert the following command: `sudo apt-get install prometheus prometheus-node-exporter -y`.
2. Edit the Prometheus config file: `sudo nano /etc/prometheus/prometheus.yml`
3. Add or modify the scrape targets IF necessary:
 
```yaml
scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
```
 
### Start, enable and access the Prometheus UI
1. Start Prometheus using: `sudo systemctl start prometheus`.
2. Enable it using: `sudo systemctl enable prometheus`.
3. Access it using your EC2's public IP with a port of `9090`.
 
These are my notes on setting them up on an EC2 but it shows u the way i installed them both