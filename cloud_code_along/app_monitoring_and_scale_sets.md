# How to connect the VM app after you stop it and start again - using  SSH key
 
1. Connect the `VM with SSH key`
2. To see the `repo/app`- need to be in root directory  -> `cd /repo/app`
3. Stop all processes -> `pm2 stop all`
4. To start the app -> `sudo pm2 start app.js`

# VM scaling

# How to increase CPU
```bash
sudo apt-get install apache2-utils
```
```bash
ab
```
# Load testing with Apache Bench
 
```bash
ab -n 1000 -c 100 http://yourwebsite.com/
 
# ab -n 1000 -c 100 http://public ip address/
# to increase the requests : ab -n 1000 -c 200...
```
 

# Dashboard VM
 
1. In the `VM` -> `Overview`-> scroll down to where is:
* Properties--Monitoring--Capabilities--Recommendations--Tutorials
2. Select `Monitoring`
3. In the monitoring window -> `Platform metrics` -> pin the metrics that we need(e.g. CPU, Disk bytes)
4. `Click pin`-> `create new`-> type(private/pubic) -> `Dashboard name`-> `Pin`

## Basics -->
1. Search "scale set" in the top search bar and click **virtual machine scale set**.
2. **Assign** resource group `(tech264)`.
3. **Name** the VM (e.g tech264-name...)
4. Set **region** to `(Europe) UK South`.
5. Select all 3 availability zones.
6. Under **orchestration mode**, select `uniform`.
7. Set the security type to `standard`.
8. For **scaling**, select `autoscaling`. A window will appear below it - click **configure**.
9. Select the pencil for the default condition to edit it.
10. Input **3** for the maximum instances / VMs.
11. Input **75** for the CPU threshold greater than.
12. Select **Save**.
13. Once returned to the basics page, select "see all images".
14. Select "my images" and search for your image - then **select**.
9. Change **username** to something more secure.
10. Change SSH public key source to `Use existing key stored in Azure`.
11. Select **your** Stored key (e.g tech264..).
 
## Disks -->
1. Change OS Disk type to `Standard SSD (locally redundant storage)`.
 
## Networking -->
1. For the **Virtual network**, Select your subnet.
2. Edit your **Network Interface**.
3. Select allow selected ports, then enable `SSH(22)` and `HTTP(80)`.
4. Ensure public IP address is **disabled** as the load balancer will handle this now.
5. Apply those changes and you will be returned to the Networking screen.
6. Select **Create a load balancer**.
7. Change the name to your naming conventions with al "lb" on the end of it, to label it as a **load balancer**.
8. Select **Create**. This will take up the "Select load balancer" slot.
 
## Health -->
1. **Tick** the box labelled "Enable application health monitoring".
2. **Tick** the box labelled "Automatic repairs".
 
## Advanced -->
1. **Tick** the box "Enable user data" to allow an input and insert:
```bash
#!/bin/bash
 
echo "Change directory to app"
cd repo/app
echo "In app directory"
 
# Stop all existing pm2 processes
pm2 stop all
 
echo "start"
pm2 start app.js
echo "App started with pm2
```
 
## Tags -->
1. Select owner and your name.
 
## Review and Create -->
1. **Ensure** you've selected the correct options.
2. **Create** your shiny new VM scale set.


Re-create your Azure VM Scale Set
Document:
steps on how to make one + test that it works
include your own diagram of how it works
explanations needed along the way
what is a load balancer and why it is needed
how to manage instances
steps on how to create an unhealthy instance (for testing) and why it is marked as healthy/unhealthy
steps on how to SSH into an instance
steps on how to delete a VM Scale Set and all it's connecting parts
Deliver link to documenation around COB