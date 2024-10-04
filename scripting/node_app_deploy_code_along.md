# Deleting Your Virtual Machine
1. Navigate to overview.
2. Find your resource group.
3. Filter your name. You will see multiple items appear.
4. Tick `resourcegroupname-name-vmname`
5. Tick `resourcegroupname-vmname-ip`
6. Tick `resourcegroupname-vmname-nsg`
7. Tick `resourcegroupname-name-networkinterface`
8. Tick `resourcegroupname-name-Disk`
9. Locate **delete**. Avoid deleting the **resource group**.
10. Tick "Apply force delete" just to be safe.
11. Enter "delete" in the input box and click **delete**.
12. Select **delete** once more to confirm **deletion**.
 
We leave the Virtual Network and SSH Key as they can be reuse
# How to run script with no user input
- Always test your commands manually first.
- `nano provision.sh` - to create a new file called provision.sh
  - `#!/bin/bash` - shows location of bash script required to run commands (called "shabang").
``` bash
#!/bin/bash
 
echo update sources list...
sudo apt-get update -y
echo Done!
 
echo upgrade any packages available...
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
echo Done!
 
echo install nginx...
sudo DEBIAN_FRONTEND=noninteractive apt-get install nginx -y
echo Done!
 
echo install nodejs v20...
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs
echo Done!
 
echo check nodejs version...
node -v
echo Done!
```
- `chmod +x provision.sh` - add execute permissions to your file
- `./provision.sh` - to execute your script

# How to add a port
1. Navigate to your VM's **network settings**.
2. Open up **Settings** and click **inbound security rules**.
3. Change the **destination port** to `3000`.
4. Change protocol to **TCP**.
5. Change the priority. The **lower** the priority, the **higher** the priority.

# how to copy node app folder from local to vm with ssh
1. go to your local machine and identify folder you want to push
2. then run `scp -i ~/.ssh/tech264-raiyan-az-key -r "C:\Users\Raiyan\Downloads\app" adminuser@20.0.184.151:~/`
    * scp
    * -i
    * path destination
3. then cd into folder and then run `npm install` and `npm start` or `node app.js`