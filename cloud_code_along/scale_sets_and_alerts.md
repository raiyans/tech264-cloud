## What is an Availability Zone? Why superior to an Availability Set? Disadvantages?

### What is an Availability Zone?
* An Availability Zone is a *physically separate location* within an Azure region. 
* Each zone has its own *independent power, cooling, and networking*. 
* Azure *guarantees* (SLA) that if you place VMs in different Availability Zones, they’ll *stay up* even if *one entire zone* (or data center) *fails*.

### Why is it superior to an Availability Set?
* **Service Level Agreement (SLA)**: specifies the *guaranteed uptime* for services (99.99%). 
* **Geographic Redundancy**: VMs placed in different Availability Zones are *located in separate physical datacenters*. This means that even if one entire datacenter goes down, your other VMs will continue running.
* **Greater Fault Isolation**: Since zones are physically isolated, they *provide better protection against datacenter-wide failures*, unlike Availability Sets, which only protect against rack-level or update-level failures.
  
### Disadvantages:
* 💸**More Expensive**: Deploying VMs across multiple Availability Zones can be more costly due to the need for *multiple redundant VMs* and the potential for *data transfer costs between zones*.
* **Delay**: While zones are in the same region, there may be slight *network delay* (latency) between VMs *located in different zones* compared to VMs within an Availability Set (which are on the same physical site).

<br>

## What is a Virtual Machine Scale Set? What type of scaling does it do? How does it work? Limitations?

### What is a Virtual Machine Scale Set?
A Virtual Machine Scale Set (VMSS) allows you to *automatically deploy and manage a group of identical VMs*. 
It enables your application to *automatically scale in or out based on demand*, ensuring you have the right amount of computing resources.

### What type of scaling does it do?
VM Scale Sets can perform:
* **Horizontal Scaling**: Automatically *adds* (scales out) or *removes* (scales in) VMs based on defined rules or demand. 
  * For example, if your website is experiencing high traffic, new VMs can be added to handle the load. Once traffic reduces, unneeded VMs can be removed.

### How does it work?
1. **Automated Scaling**: You *define scaling rules based on metrics* like CPU usage, memory, or custom metrics. Azure monitors these metrics and adds/removes VMs accordingly.
2. **Load Balancing**: Azure *automatically distributes traffic* across all the VMs in your scale set to make sure no single VM is overloaded.
3. **Fault Tolerance**: VMSS (VM Scale Set) can be configured to use Availability Zones or Availability Sets to ensure high availability.

### Limitations:
* **Identical VMs**: All VMs in a scale set are *identical*, which might not suit applications needing different configurations on different VMs.
* **Scaling Delay**: While VMSS can scale automatically, adding new VMs can *take a few minutes*, meaning it *might not react instantly* to traffic spikes.
* **Complex Configuration**: Setting up and managing scaling rules and auto-scaling behavior can be *complex*, especially for beginners. You need to carefully tune these settings to avoid unnecessary costs or performance issues.

<br>


| Feature               | **Advantages**                                                       | **Disadvantages**                                                |
|-----------------------|----------------------------------------------------------------------|------------------------------------------------------------------|
| **Availability Set**   | Cost-effective, protects against rack failures, improves uptime within a datacenter | Doesn’t protect against full datacenter failure, limited to a single region |
| **Availability Zone**  | Protects against datacenter failure, provides greater fault isolation | Higher costs, potential for network latency between zones        |
| **VM Scale Set**       | Auto-scales based on demand, load balancing built-in, supports Availability Sets/Zones | VMs must be identical, scaling can have delays, more complex to configure |

<br>

# Making an Alert for app vm
### Steps to Create an Alert for a VM on Azure

#### 1. **Navigate to Azure Monitor**
   - Log in to the [Azure portal](https://portal.azure.com/).
   - In the search bar at the top, type **"Monitor"** and select **Monitor** from the list of results.

#### 2. **Create a New Alert Rule**
   - In the **Monitor** page, on the left-hand menu, select **Alerts**.
   - Click **New alert rule** at the top of the Alerts page.

#### 3. **Select the Target Resource (VM)**
   - Under the **Scope** section, click **Select resource**.
   - In the **Resource Type** dropdown, select **Virtual Machine**.
   - Choose the VM you want to monitor from the list of available resources and click **Done**.

#### 4. **Define the Alert Condition**
   - In the **Condition** section, click **Add condition**.
   - You will see a list of available metrics (like CPU, memory, disk, network, etc.).
   - Select a metric, such as **Percentage CPU**, to monitor CPU usage.
   - Configure the condition:
     - Set the **threshold** value (e.g., alert if CPU usage is over 80% for 5 minutes).
     - Set the **aggregation** (e.g., average over the last 5 minutes).
   - Click **Done** when you’ve configured the condition.

#### 5. **Configure Action Group (Who to Notify)**
   - In the **Actions** section, click **Add action group**.
   - An action group defines what happens when the alert is triggered, such as sending an email, SMS, or running an automation.
   - Click **+ Create action group** and fill in the details:
     - **Action group name**: Give it a meaningful name (e.g., "CPU-Alert-Group").
     - **Notification type**: Choose the type of notification you want (e.g., email, SMS).
     - Enter the recipient details (e.g., email address or phone number).
   - Click **OK** to create the action group.

#### 6. **Set the Alert Rule Name and Severity**
   - In the **Alert rule details** section, provide:
     - **Alert rule name**: Name your alert (e.g., "High CPU Alert").
     - **Description**: Optionally, add a description of what this alert is monitoring.
     - **Severity**: Select a severity level (e.g., Sev 1 for critical alerts, Sev 4 for informational).
   
<br> 

![alt text](./scripting/images/image-8.png)
  
<br> 

#### 7. **Create the Alert**
   - Review your settings, then click **Create alert rule**.
   - Azure will now monitor the specified condition, and when it crosses the threshold you’ve set, the alert will trigger, and the action group will notify you.

### Below is the review & Create Page:

![alt text](./scripting/images/image-10.png)

![alt text](./scripting/images/image-11.png)


# Getting an Alert
* install : `sudo apt-get install apache2-utils -y`
* to try and get an alert: `ab -n 10000 -c 200 http://172.187.129.73/ 
> If I had held my patience, this would have eventually given me an alert over 70%.


## Generate CPU load using stress
With less patience, i tried this: 
Install stress: `sudo apt-get install stress`
* This runs 4 workers that consume CPU for 100 seconds
`stress --cpu 4 --timeout 100`


## Alerts to my Email

![alt text](./scripting/images/image-12.png)

![alt text](./scripting/images/image-13.png)

![alt text](./scripting/images/Screenshot.png)


<br>

| Feature             | Route Tables                                      | IPTables                                      | NSG Rules                                      |
|---------------------|---------------------------------------------------|-----------------------------------------------|------------------------------------------------|
| **Primary Function**| Route traffic to the correct network segment.     | Filter traffic based on IP, port, protocol.   | Allow or deny traffic to/from Azure resources. |
| **Where Used**      | Azure VNets, subnets, routers, gateways.          | Linux VMs, Network Virtual Appliances (NVAs). | Azure resources (VMs, NICs, subnets).          |
| **Scope**           | Network-wide routing decisions.                   | Per-machine firewalling and packet control.   | Subnet or VM-level traffic filtering.          |
| **Traffic Control** | Directs traffic based on destination IP.          | Filters traffic based on IP, port, protocol (Layer 3 & 4). | Controls traffic based on IP, port, protocol (Layer 4). |
| **Typical Use Case**| Routes traffic between subnets or to the internet.| Allows or blocks traffic at the VM level (Linux). | Controls inbound/outbound traffic to Azure VMs or NICs. |
| **Example**         | Route traffic to DB subnet via NVA in DMZ.        | Block all SSH traffic except from one IP.     | Allow HTTP traffic from the internet to a VM.  |


<br>

