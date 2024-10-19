# Auto scaling
1. `Adjusting Resources Automatically`: Auto scaling automatically adds more “staff” (computers or servers) when there’s a lot of traffic to your website or application. When the traffic goes down, it reduces the number of servers, so you’re not paying for resources you don’t need.
  
2. `Efficiency`: This helps ensure your website runs smoothly without wasting money. You have just the right amount of resources at any given time.
  
3. `Types of Scaling`:
   * *Scaling Out/In* (Horizontal Scaling): This means adding more servers when needed and removing them when they’re not. It’s like hiring extra staff for busy days and letting them go when things are quiet.
   * *Scaling Up/Down* (Vertical Scaling): This means making your existing servers more powerful or less powerful. It’s like giving your staff extra tools to work faster or taking them away when they’re not needed.

4. `Why It’s Useful`: Auto scaling is great for websites or apps that have unpredictable traffic. For example, an online store might get a lot of visitors during a sale, or a news site might get a spike in traffic when big news breaks.
   
5. `How It Works`: Cloud providers like AWS, Azure, and Google Cloud offer auto scaling services. They monitor your application and adjust the resources based on how busy it is, following rules you set up.
   
> Auto scaling helps your website or app handle more visitors when needed and saves money when things are quiet, all without you having to manually adjust anything.

---

![types-of-scaling](/images/types-of-scaling.png)


# Types of Scaling

## Vertical Scaling

### 1. Scalling-up
   * Scaling up in VMs means **increasing the power** of your existing VM. You might add more CPU, RAM, or storage to handle more tasks.
   * Scaling-up: increasing the size of the VM.
   * It copies whatever work load is on this VM and is copied to a bigger VM. 
   * Once its copied the workload, it deletes the smaller VM. 

### 2. Scaling-down
  * Scaling down means **reducing the power of your VM**. 
  * You might decrease the CPU, RAM, or storage when you don’t need as much capacity.


## Horizontal Scaling

### 1. Scaling-out
  * In the world of VMs, scaling out means **adding more VMs to handle increased load**. If your website gets a lot of visitors, you add more VMs to share the work.
  * You may get more of those VM's duplicated. 

### 2. Scaling-in
  * Scaling in means removing some VMs when the load decreases.
  * This helps save resources and money.


## Real-World Example
* Imagine you run an online store. During a big sale, lots of people visit your site:

* `Horizontal Scaling`: You **add more VMs** to handle all the visitors. After the sale, you remove the extra VMs.
* `Vertical Scaling`: If you expect a steady increase in traffic, you might **upgrade** your main VM to handle more visitors **without adding new ones**.


#### To summerise:
* **horizontal** scaling *adds or removes* VMs to match the load.
* **vertical** scaling *changes the power* of your existing VM. 
* Both methods help ensure your application *runs smoothl*y and *efficiently*.

--- 


# What Availability options on Azure

## What is an Availability Set?
* An Availability Set in Azure is a *feature* that helps *ensure* your Virtual Machines (*VMs) stay online during planned or unplanned downtime *(e.g., maintenance or hardware failures). 
* It *spreads your VMs across multiple isolated hardware nodes* (a physical server or a machine within a data center), making sure they *aren’t all affected by the same failure*.

### How does it work?
When you place VMs in an Availability Set, Azure automatically distributes them across:

* **Fault Domains**: *Physical hardware racks* in the datacenter. If one rack fails, VMs in different racks will continue running.
* **Update Domains**: *Logical groups that allow Azure to perform maintenance on your VMs in stages*. If one update domain is undergoing maintenance, the others will remain online.

### Advantages:
* **High Availability**: VMs in an Availability Set are *protected from hardware failures* and *planned Azure maintenance*. This improves uptime.
* **Cost-Effective**: There's *no extra cost* for using Availability Sets; you only pay for the VMs you run.
* **Load Balancing**: It helps in *balancing the load across different servers*, ensuring no single server is overwhelmed.

### Disadvantages:
* **Single Datacenter**: Availability Sets protect against failures within a single Azure region, but they *don’t provide protection if the entire datacenter goes offline*.
* **No Zone Redundancy**: Availability Sets *only work within a single Azure region* and *don’t spread VMs across multiple geographic areas* (like Availability Zones can).


<br>


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
