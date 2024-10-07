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
2. Better Alternative is using rsync 
   * `sudo apt update`
   * `sudo apt install rsync`
   * Then run `rsync -avz -e "ssh -i ~/.ssh/tech264-raiyan-az-key" /path/to/local/folder/ adminuser@20.0.184.151:/path/to/remote/folder/`

3. then cd into folder and then run `npm install` and `npm start` or `node app.js`

# database vm

1. private subnet
create the vm and name it tech-264-raiyan-run-db
ports open, not http need ssh only
personal key 

2. sudo apt update and upgrade
* mongodb to install
3. get the gpg package
`sudo apt-get install gnupg curl`
checks if package is aunthentic  
```bash
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
   ```

4. create a sources list file of the 
``` bash
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
```


* do another update `sudo apt-get update -y`

5. install the mongodb server 

``` sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 mongodb-org-server=7.0.6 mongodb-mongosh=2.1.5 mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6 ```


6. check if mongo is active
`sudo systemctl status mongod`

## start mongodb
`sudo `

7. edit config mongo file
 `sudo nano /etc/mongod.conf`
 change bind ip from 127.0.0.0 to 0.0.0.0 to accept connections from any ip address

8. restart to let it start back up everytime vm restarts
`sudo systemctl restart mongod`
`sudo systemctl is-enabled mongod`
`sudo systemctl enable mongod`



# switch to the app vm
1. go cd into app
* use private ip first if available before using public ip

2. we will make an env variable for the db string to connect to 
`export DB_HOST=mongodb://10.0.3.4:27017/posts`
3. check env var is set
`printenv DB_HOST`

4. run npm install and you should see database is seeded in the logs

now you can see the posts sourced from the db on the node app with the public ip and port 3000 for the node app vm
http://20.0.184.151:3000/posts