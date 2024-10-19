
When creating a VM:
* Azure, by default you get a static (fixed) Public IP address

* On AWS by default you will get a dynamic (changable) Public IP address
After restartin a vm in AWS the public IP will change.

# AWS vs. Azure: Virtual Networks and Virtual Machines

When creating **Virtual Networks (VNet)** and **Virtual Machines (VMs)** on **AWS (Amazon Web Services)** and **Azure (Microsoft Azure)**, there are several key differences. Here's a detailed comparison of the two cloud platforms for these services:

## 1. Virtual Networks (VNet)
Both AWS and Azure provide capabilities to create isolated virtual networks, but they use different terminologies and have varying features.

### **AWS (Amazon Web Services)**
- **Service Name**: **VPC (Virtual Private Cloud)**
- **Subnet Types**: Public and Private subnets.
- **Networking Model**: 
  - VPCs can span across multiple **Availability Zones (AZs)** within a region. You define the range of IP addresses and subnets within that range.
- **IP Addressing**: Supports both IPv4 and IPv6.
- **Peering**: You can create VPC Peering connections to connect VPCs within the same or different AWS regions.
- **VPC Endpoints**: These are used to privately connect your VPC to supported AWS services without needing a public IP.
- **Route Tables**: Controls traffic routing within and outside the VPC.
- **Default VPC**: AWS provides a default VPC with a pre-configured public subnet in every region.
- **Security**: Managed via **Security Groups** (stateful firewall rules) and **Network Access Control Lists (ACLs)** (stateless).

### **Azure**
- **Service Name**: **Virtual Network (VNet)**
- **Subnet Types**: Azure VNets have a more uniform approach to subnets (no distinct public/private subnet, handled with NSGs and routing).
- **Networking Model**: 
  - VNets are also regional but can be divided into **Subnets**, which are isolated within an **Availability Zone** or **Region**.
- **IP Addressing**: Supports both IPv4 and IPv6.
- **Peering**: VNet Peering connects VNets within the same or different Azure regions.
- **Service Endpoints**: Similar to AWS VPC endpoints, these allow access to Azure services over private IP addresses.
- **Route Tables**: Uses routing tables to direct traffic within VNets and externally.
- **Default VNet**: Azure doesn’t automatically create a default VNet, but one can be created quickly via the portal.
- **Security**: Managed via **Network Security Groups (NSGs)**, which can be applied at subnet or VM level (stateless).

### **Key Differences in Virtual Networks**:
- AWS VPC has a more explicit distinction between public and private subnets.
- Azure NSGs can be applied at both subnet and NIC (VM) level, giving finer control.
- AWS provides default VPCs, while Azure does not create a default VNet.
- Azure VNets can connect to Azure services more easily via service endpoints, but AWS has VPC endpoints with better security integration options.

---

## 2. Virtual Machines (VMs)
Both AWS and Azure offer virtual machines with a variety of configurations, but they have differences in how they manage instances, storage, and deployment options.

### **AWS (Amazon Web Services)**
- **Service Name**: **EC2 (Elastic Compute Cloud)**
- **Instance Types**: A wide variety of instance types, ranging from general-purpose, compute-optimized, memory-optimized, GPU-based, and more.
- **Storage**: 
  - **EBS (Elastic Block Store)**: Persistent storage for instances, with options for SSD and HDD types.
  - **Instance Store**: Ephemeral storage that is tied to the lifecycle of the instance.
- **Scaling**: 
  - **Auto Scaling** allows you to scale the number of EC2 instances based on demand (up or down).
  - **Elastic Load Balancing (ELB)** distributes traffic across multiple instances.
- **AMI (Amazon Machine Images)**: Preconfigured templates (including OS, configurations, and application data) that can be used to launch instances.
- **Spot Instances**: Allows you to bid for unused EC2 capacity at a lower cost.
- **Pricing**: Pay-as-you-go, Reserved Instances (discounted with long-term commitment), and Spot Instances for savings.

### **Azure**
- **Service Name**: **Azure Virtual Machines (VMs)**
- **Instance Types**: Similar to AWS, Azure VMs are available in different configurations such as General Purpose, Compute-Optimized, Memory-Optimized, and GPU instances.
- **Storage**: 
  - **Managed Disks**: Azure manages the storage for you, ensuring reliability and high availability. You can choose between SSD and HDD.
  - **Temporary Disks**: Azure provides ephemeral storage for temporary data, which is deleted when the VM is stopped.
- **Scaling**: 
  - **Azure Virtual Machine Scale Sets (VMSS)** can scale VMs automatically based on load.
  - **Azure Load Balancer** distributes traffic across multiple VMs.
- **VM Images**: Azure Marketplace provides pre-built VM images (Linux, Windows, third-party software), similar to AWS AMIs.
- **Spot VMs**: Azure also offers **Spot VMs**, which are similar to AWS Spot Instances, where you pay less for spare capacity.
- **Pricing**: Includes pay-as-you-go, Reserved VM Instances (1 or 3-year commitment), and Spot VMs for cost savings.

### **Key Differences in Virtual Machines**:
- **Instance Types**: Both platforms offer a similar variety of instance types, but AWS has a longer history with more specialized instances.
- **Storage**: Azure uses **Managed Disks** for easier management, while AWS provides more flexibility through **EBS** and **Instance Stores**.
- **Scaling**: AWS Auto Scaling is well-established, but Azure VM Scale Sets (VMSS) provides comparable automatic scaling features.
- **Spot Instances/VMs**: Both AWS and Azure offer the ability to purchase spot instances/VMs at lower prices, but AWS Spot Instances have been around longer and may be more robust.
- **Management Interface**: AWS uses AMIs for VM templates, while Azure uses VM Images from its Marketplace.

---

## 3. Additional Considerations
- **Hybrid Connectivity**:
  - **AWS** offers **Direct Connect** to create a dedicated network connection from your premises to AWS.
  - **Azure** provides **ExpressRoute** for private network connections from on-premises to Azure.

- **Integration with Other Services**:
  - Both platforms integrate well with their other cloud services, but AWS is known for deeper service integration due to its longer time in the market.

- **Networking Features**:
  - Azure tends to be more user-friendly with integrated networking services, while AWS provides more granular control and flexibility in VPC setup.

---

## Summary Table:

| Feature              | AWS (VPC + EC2)                          | Azure (VNet + VMs)                       |
|----------------------|-------------------------------------------|------------------------------------------|
| **Virtual Network**   | VPC (Public and Private Subnets)          | VNet (No strict public/private subnet)   |
| **Peering**           | VPC Peering                               | VNet Peering                             |
| **Endpoints**         | VPC Endpoints                             | Service Endpoints                        |
| **Scaling**           | Auto Scaling for EC2                     | VM Scale Sets (VMSS)                     |
| **Spot Pricing**      | Spot Instances                            | Spot VMs                                 |
| **Load Balancing**    | Elastic Load Balancer (ELB)               | Azure Load Balancer                      |
| **Storage**           | EBS (persistent) + Instance Store (ephemeral) | Managed Disks + Temporary Disks         |
| **Networking**        | Security Groups and NACLs (stateful/stateless) | NSGs (stateless)                         |
| **Pricing Models**    | Pay-as-you-go, Reserved, Spot Instances   | Pay-as-you-go, Reserved, Spot VMs        |

In summary, AWS and Azure offer similar core functionality, but AWS generally offers more granular control, while Azure provides a more integrated and user-friendly experience. Your choice depends on which platform aligns with your existing services and preferences.
