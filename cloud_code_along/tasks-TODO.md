Document:  15-20min
steps on how to do it, with explanations and essential screenshots
include your own diagram on the 3-subnet architecture


Research: 15-20min

What is an availability set? How do they work? Advantages/disadvantages?
What is an availability zone? Why superior to an availability set? Disadvantages?
What is a Virtual Machine Scale Set? What type of scaling does it do? How does it work? Limitations?



Document what was done in the code-along, including...
What is worst to best in terms of monitoring and responding to load/traffic.
How you setup a dashboard
How a combination of load testing and the dashboard helped us
Include a screenshot of your dashboard when you manage to get it to stop responding through extreme load testing
Create a CPU usage alert for your app instance → you should get a notification sent your email
Get the alert to check the average for each minute
Document...
How to setup CPU usage alert
Include a screenshot of the email you received as a notification
Post a link to your documentation in the chat around COB
In Azure, remove your dashboards and alert and action group
Document...
How to clean up for this task
Link to help with Step 2 above: https://www.stephenhackers.co.uk/azure-monitoring-alert-on-virtual-machine-cpu-usage/

Hints:

You need to set the threshold low enough that the CPU utilization will trigger an alert when you do heavy load testing and you get an email notification
During cleanup: After deleting your alert, you will still need to delete your action group




``` bash
#!/bin/bash
 
# configure iptables
 
echo "Configuring iptables..."
 
# ADD COMMENT ABOUT WHAT THE FOLLOWING COMMAND(S) DO
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT
 
# ADD COMMENT ABOUT WHAT THE FOLLOWING COMMAND(S) DO
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
 
# ADD COMMENT ABOUT WHAT THE FOLLOWING COMMAND(S) DO
sudo iptables -A OUTPUT -m state --state ESTABLISHED -j ACCEPT
 
# ADD COMMENT ABOUT WHAT THE FOLLOWING COMMAND(S) DO
sudo iptables -A INPUT -m state --state INVALID -j DROP
 
# ADD COMMENT ABOUT WHAT THE FOLLOWING COMMAND(S) DO
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
 
# uncomment the following lines if want allow SSH into NVA only through the public subnet (app VM as a jumpbox)
# this must be done once the NVA's public IP address is removed
#sudo iptables -A INPUT -p tcp -s 10.0.2.0/24 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#sudo iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
 
# uncomment the following lines if want allow SSH to other servers using the NVA as a jumpbox
# if need to make outgoing SSH connections with other servers from NVA
#sudo iptables -A OUTPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
#sudo iptables -A INPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
 
# ADD COMMENT ABOUT WHAT THE FOLLOWING COMMAND(S) DO
sudo iptables -A FORWARD -p tcp -s 10.0.2.0/24 -d 10.0.4.0/24 --destination-port 27017 -m tcp -j ACCEPT
 
# ADD COMMENT ABOUT WHAT THE FOLLOWING COMMAND(S) DO
sudo iptables -A FORWARD -p icmp -s 10.0.2.0/24 -d 10.0.4.0/24 -m state --state NEW,ESTABLISHED -j ACCEPT
 
# ADD COMMENT ABOUT WHAT THE FOLLOWING COMMAND(S) DO
sudo iptables -P INPUT DROP
 
# ADD COMMENT ABOUT WHAT THE FOLLOWING COMMAND(S) DO
sudo iptables -P FORWARD DROP
 
echo "Done!"
echo ""
 
# make iptables rules persistent
# it will ask for user input by default
 
echo "Make iptables rules persistent..."
sudo DEBIAN_FRONTEND=noninteractive apt install iptables-persistent -y
echo "Done!"
echo ""
```

`sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y`




7. **IP forwarding**
We need to associate the route table to where the traffic comes out of.
 
**In route table**
1. In route table subnet -> **Settings** -> **Subnets**
2. Click **Associate**
3. Choose your virtual network(in this case tech264-maria-3-subnet-vnet)
4. Select the **public-subnet**
 
**In NIC for NVA**
- We need to enable IP forwarding.
1. In **NVA** -> **Networking settings** -> **Network Interface/ IP configuration link**
 
![NVA NIC](<images/NVA NIC.png>)
 
2. Enable **IP forwarding** and click **Apply**
 
![enable-ip-forwarding](<images/NIC NVA enable.png>)
 
 
**In NVA(linux):**
1. SSH in NVA
2.
```bash
sysctl net.ipv4.ip_forward
```
1.
```bash
sudo nano /etc/sysctl.conf
# need to uncomment the net.ipv4.ip_forward=1
```
<br>
 
![IP-forwarding](images/IP-forwarding.png)
 
4.
```bash
sudo sysctl -p
#(reload the configuration)
```
If your `ping (DB Private IP)` command was running on another window, you'll see that it has resumed, meaning the packets are now being forwarded to the DB VM through the NVA. This also shows that the route table is working correctly.
 
![ping-statistics](<images/ping 10.0.4.4.png>)
 
 
**IP tables rule(works as a firewall)**
- We need a script that will contain the rules we're going to set. SSH into your NVA.
1.
```bash
nano config-ip-tables.sh
# create the script
```
[config-ip-tables](config-ip-tables.sh)
 
2.
```bash
chmod +x config-ip-tables.sh
# give permission
```
3.
```bash
ls
# show the script
```
4.
```bash
sudo apt update -y
# update
```
5.
```bash
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
# upgrade
```
6.
```bash
./config-ip-tables.sh
# run the script
```
 
 
 
**Setting the rules in MongoDB VM**
1. Navigate to your **DB virtual machine**.
2. Go to **Network Settings** under **Networking**.
3. Click the `tech264-maria-in-3-subnet-vnet-vm-nsg` link next to **Network security group** .
4. Go to **inbound port rules** and click **Add**.
5. Under **Source**, select **IP addresses**.
6. Under **Source IP addresses/CIDR ranges**, input the **public subnet IP** `10.0.2.0/24`.
7. Change the service to MongoDB.
8. Change the name appropriately.
 
![mongoDB-rule](images/mongodb-rule.png)
 
## Create a rule to deny everything else
1. **Add** another rule.
2. Input a `*` to the **destination port ranges**.
3. Change the priority to `500`.
 
![deny-everything-rule](images/deny-everything-rule.png)