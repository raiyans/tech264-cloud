## Diagram of structure
   ![2-tier](/images/3-subnet-2-tier-deploy.png)

### Steps for Code-along
1. set up a new vnet - 3 subnet version
   1.  create 3 subnets and name then appropriately
   2.  give the addresses 10.0.2.0 for the public, 3 for the dmz and 4 for the private subnet
   3. for the private subnet enable the no outbound access - this mean whatever is in the subnet cannot access the internet
   4. tag yourself as owner
   5. create
2. Create db vm from image
   1. go to your ready-to-run-db image
   2. create a vm
   3. name appropriately
   4. for availability- self select and db in zone 3
   5. allow ssh (for now)
   6. disk as normal
   7. networking - choose the right vnet and subnet, no public ip
   ![alt text](image-3.png)
3. Create the app vm from image
   1. go to your ready-to-run-app image
   2. create a vm
   3. name
   4. for availability- self select and db in zone 1
   5. allow http and ssh
   6. disk as normal
   7. networking - choose the right vnet (3 subnet vnet) and subnet (public)
4. Create NVA vm
   1. create with ramons's clean image image
   2. name
   3. for availability- self select and db in zone 2
   4. allow just ssh
   5. disk as usual
   6. networking - choose the right vnet (3 subnet vnet) and subnet (dmz)
   7. give public ip (for now) to allow us to ssh in
   8. no user data - can upgrade and update when we ssh in
   9. create
5. Set a ping (sends a packet regularly) to check the comms between the app and the db vms
   1. ssh into the app vm
   2. we want to ping the db vm ```ping 10.0.4.4```
   3. each message is the db replying and it also tells you how long the response takes (ctrl c/z to exit)
    ![alt text](image-4.png)
6. set up routing (using a routing table)
   1. search route table on az
   2. create
   ![alt text](image-5.png)
   3. go to resources
   4. add a route

## Route Tables
 
1. Select **tech264** resource group.
2. For **Region**, Select **UK South**.
 
### --> Review and Create
1. **Ensure** you've selected the correct options. There isn't really much here, really.
2. **Create** your shiny new Route table.
 
### --> Once it's created, navigate to the resource.
 
3. Go to the **Settings** drop down.
4. Click **Routes**.
5. Click **Add**.


start app cmds
```bash
#Set MongoDB connecting string
export DB_HOST="mongodb://10.0.4.4:27017"  # IMPORTANT CHANGE THIS IF NOT THE SAME DB IP
# CD into app directory
echo "Change directory to app"
cd /repo/app
echo "In app directory"
# Stop all existing pm2 processes
sudo -E pm2 stop all
# Start app
echo "start"
sudo -E pm2 start app.js
echo "App started with pm2"
```
# Re-create the 3-subnet architecture to make the database private

![2-tier](/images/3-subnet-2-tier-deploy.png)
 
## Securing the DB with a DMZ subnet- 3 subnet vnet

 Our private subnet currently doesn't have anymore security than our public:
 [securing-db](/0_research/8_securing_db.md)

#### Quick increase of db w/o nva
 current subnet allows communication between vms in the same subnet

 - Delete the the public IP of the db vm
  - add a nsg rule that stops this- disallow any traffic 
    - you must then allow db vm to allow communication from the MONGODB database by allowing traffic from it's port - (27017)
  - by default vnet comms is not allowed anymore

if you just delete your public ip for your db subnet then you can ssh in through a public vm and ssh into your priv vm- you must include port and have the private key for the private vm on your public vm

nva (network virtual appliance) - filters any traffic that wants to access to the db, only legit traffic from correct source
 - to force the traffic to go a particular direction, a route table is used
 - the traffic out of the public subnet, and the "next hop"
 - goes to the nsg group of the nva vm and is checked 
   - in the nic of the nva db IP forwarding is enabled
   - in the actual nva vm IP forwarding also needs to set up
   - also IP tables (often used in firewalls) basically acting as a fire wall for your db
 - and then the forwarded (filtered) traffic goes to the private subnet that and therefore the db vm

 
## Set up the Virtual Network
 
### --> Basics
1. Name appropriately (tech264-name-in-3-subnet-vnet)
 
### --> IP addresses
1. Edit **default subnet**, rename to **public-subnet** and change **starting address** to `10.0.2.0`.
2. Add a new subnet, rename to dmz-subnet and change **starting address** to `10.0.3.0`.
3. Add another new subnet for private subnet, rename to private-subnet and change **starting address** to` 10.0.4.0` and enable **private subnet**. This means that whatever you put in this subnet cannot access the internet.
 
### --> Tags
1. Select owner and your name.
 
### --> Review and Create
1. **Ensure** you've selected the correct options.
2. **Create** your shiny new secure virtual network.
 
## FIRST OF 3: Create Database VM
Now we create a virtual machine using our database image. We start with the database as we follow the 2-tier architecture sructure.
 
Follow the usual **DATABASE** steps with these slight changes...
 
### --> Basics
1. Select **zone 3** for avaialiblity zone assigned to the DB.
2. Select the previously created virtual network and select the private subnet. 10.0.4.0
3. Disable public IP address.
4. Only enable **SSH port**.
 
### --> Review and Create
1. **Ensure** you've selected the correct options.
2. **Create** your shiny new DB.
 
Once this is done, we create the application that will connect to the database and display the information.
 
## SECOND OF 3: Create the App VM
Follow the usual **APP** steps with these slight changes...
 
### --> Basics
1. Select **zone 1** for avaialiblity zone assigned to the App.
 
### --> Networking
1. Select public subnet.
 
### --> Advanced
1. Enable **user data** and input your `image script` (script you use to run the image).
2. Change the **IP** in the **export line** to the **private IP** of the **DB** we created previously.
 
### --> Review and Create
1. **Ensure** you've selected the correct options.
2. **Create** your shiny new App.
 
We can use `ping 10.0.4.4` to ensure the connection between app and the database have been established and are working. To do this, `ssh` into the app VM and input the command.
 
## THIRD OF 3: Create the NVA VM
Now we create the VM for the Network Virtual Appliance (NVA). This performs network functions like routing, firewalling, trafic filtering and load balancing.
 
### --> Basics
1. Name it appropriately (tech264-name-in-3-subnet-nva).
2. Select **zone 2** for avaialiblity zone assigned to the NVA.
3. Select **Standard security** as it may have changed.
4. Select **see all images** and find the **clean-image**.
5. Leave SSH as the only port.
 
### --> Networking
1. Use the **DMZ subnet**.
2. Leave the public IP initially. later on if we used in production, we wouldn't.
 
### --> Review and Create
1. **Ensure** you've selected the correct options.
2. **Create** your shiny new NVA.
 
## Route Tables
Used to define how network traffic is directed within a network and between different networks.

1. Set a ping (sends a packet regularly) to check the comms between the app and the db vms
   1. ssh into the app vm
   2. we want to ping the db vm ```ping 10.0.4.4```
   3. each message is the db replying and it also tells you how long the response takes (ctrl c/z to exit)
    ![alt text](/images/nva-ping.png)
 
2. Select **tech264** resource group.
3. For **Region**, Select **UK South**.
 
### --> Review and Create
1. **Ensure** you've selected the correct options. There isn't really much here, really.
2. **Create** your shiny new Route table.
 
Once it's created, navigate to the resource.
 
### --> Routes under Settings
2. Click **Routes**.
3. Click **Add**.
4. For the **route name**, input `to-private-subnet-route`.
5. For the **destination type**, select **IP addresses**.
6. For **Destination IP addresses/CIDR ranges**, we use the private subnet: `10.0.4.0/24`.
7. For the next **hop type**, select **Virtual appliance**.
8. For the next **hop address** input the **IP** of the NVA: `10.0.3.4`.
9. Select **Add**.
    <br>
     ![alt text](/images/nva-routes.png)
 
Now we need to associate the route table to where the traffic comes out of.
 
### --> Subnet under Settings
1. Click **Associate**.s
1. Choose your virtual network.
2. Select the **public-subnet**.
 ![nsg](/images/nva-associate.png)
 
### --> Network Settings under Networking for your NVA
1. Select the **network settings** and then **Network Interface / IP configuration** link.
   ![nsg](/images/nva-nsg.png)
2. Enable **IP forwarding** and click **Apply**.
 
### Now, we have to enable it on Linux.
***Remember!** you need to update and upgrade on new VMs.*
 
1. **SSH** into your **NVA**.
2. Input `sysctl net.ipv4.ip_forward` to check if IP forwarding is enabled. If it reads **0**, it's false.
3. Input `sudo nano /etc/sysctl.conf` to enter the config file where we can enable it.
4. You will need to uncomment the line to enable it. Ensure you do the correct **IPv type**. In our case, it's **IPv4**.
 
  ![alt text](/images/nva-ip4-config.png)
 
1. If you run another check, it'll read as 0 still. So, we need to apply to configuration file changes by reloading it. We can use `sudo sysctl -p`. It will then print that the setting has been changed.
 
If your `ping (DB Private IP)` command was running on another window, you'll see that it has resumed, meaning the packets are now being forwarded to the DB VM through the NVA. This also shows that the route table is working correctly.
 
## Creating IP Table Rules
We need a script that will contain the rules we're going to set. SSH into your NVA.
 
1. Create a file called `nano config-ip-tables.sh`, where will write the script.
2. Write the script: 
[IP Tables script](/script_reference/5_0_config-iptables-script.sh)
``` bash
#!/bin/bash 
 
# configure iptables
 
echo "Configuring iptables..."
 
# Allow all incoming and outgoing traffic on the loopback interface (localhost)
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT
 
# Allow incoming traffic that is part of an established connection or related to an established connection
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
 
# Allow outgoing traffic that is part of an established connection
sudo iptables -A OUTPUT -m state --state ESTABLISHED -j ACCEPT
 
# Drop any incoming packets that are in an invalid state
sudo iptables -A INPUT -m state --state INVALID -j DROP
 
# Allow incoming SSH traffic on port 22 for new and established connections
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
# Allow outgoing SSH traffic on port 22 for established connections
sudo iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
 
# uncomment the following lines if want allow SSH into NVA only through the public subnet (app VM as a jumpbox)
# this must be done once the NVA's public IP address is removed
#sudo iptables -A INPUT -p tcp -s 10.0.2.0/24 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#sudo iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
 
# uncomment the following lines if want allow SSH to other servers using the NVA as a jumpbox
# if need to make outgoing SSH connections with other servers from NVA
#sudo iptables -A OUTPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
#sudo iptables -A INPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
 
# Allow TCP traffic from the source subnet (10.0.2.0/24) to the destination subnet (10.0.4.0/24) on port 27017
sudo iptables -A FORWARD -p tcp -s 10.0.2.0/24 -d 10.0.4.0/24 --destination-port 27017 -m tcp -j ACCEPT
 
# Allow ICMP traffic (ping) from the source subnet (10.0.2.0/24) to the destination subnet (10.0.4.0/24) for new and established connections
sudo iptables -A FORWARD -p icmp -s 10.0.2.0/24 -d 10.0.4.0/24 -m state --state NEW,ESTABLISHED -j ACCEPT
 
# Set the default policy for incoming packets to DROP
sudo iptables -P INPUT DROP
 
# Set the default policy for forwarded packets to DROP
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
 
***Sidenote! What these flags / options mean:***
 
`-A` : Stands for "Append." It adds a new rule to the end of a specified chain (e.g., INPUT, OUTPUT, FORWARD).
 
`-i` : Stands for "Input interface." It specifies the network interface for incoming traffic.
 
`-o` : Stands for "Output interface." It specifies the network interface for outgoing traffic.
 
`-p` : Stands for "Protocol." It specifies the protocol used (e.g., TCP, UDP, ICMP).
 
`--dport` : Stands for "Destination port." It specifies the port number for incoming traffic.
 
`--sport` : Stands for "Source port." It specifies the port number for outgoing traffic.
 
`-m` : Stands for "Match." It specifies a module that provides additional matching criteria (e.g., state, conntrack).
 
`--state` : Used with the -m state module to specify the state of the connection (e.g., NEW, ESTABLISHED, RELATED, INVALID).
 
`-j` : Stands for "Jump." It specifies the target action to take when a rule matches (e.g., ACCEPT, DROP, REJECT).
 
3. Grant yourself execute permissions using `chmod +x config-ip-tables.sh`. You can `ls` and see if it's green. If it is, you can execute it.
4. Run your script with `./config-ip-tables.sh`.
 
## Set Network Security Group Rules
1. Navigate to your **DB virtual machine**.
2. Go to **Network Settings** under **Networking**.
3. Click the `tech264-kagan-in-3-subnet-vnet-vm-nsg` link next to **Network security group**.
  ![nsg rules](/images/nva-nsg-rules.png)
4. Go to **inbound port rules** and click **Add**.
5. Under **Source**, select **IP addresses**.
6. Under **Source IP addresses/CIDR ranges**, input the **public subnet IP** `10.0.2.0/24`.
7. Change the service to MongoDB.
8. Change the name appropriately.
   ![nsg rules](/images/nva-inbound-rule.png)
 
## Create a rule to deny everything else
1. **Add** another rule.
2. Input a `*` to the **destination port ranges**.
3. Change the priority to `500`.
![deny rules](/images/nva-rule-deny.png)
 
*That's it! You've officially secured your app with a DMZ layer. Good stuff. Now delete it all.*

4. Clean up
   1. go to resource group
   2. search name
   3. delete everything but images, subnets and ssh key
   4. to delete route table - disassociate it from any subnets

***If you want to get the app "talking" to the db without the route/route table you can disassociate the public ip from the route***