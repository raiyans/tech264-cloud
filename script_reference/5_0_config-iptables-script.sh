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
