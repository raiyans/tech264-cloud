# cloud diagram recreated
* https://lucid.app/lucidchart/2e8e8991-8471-4bed-a4e6-10e3e2881810/edit?viewport_loc=-1087%2C-1714%2C2112%2C2469%2C0_0&invitationId=inv_54f48fdd-5e6d-4a6b-86b9-5a99b590c334
  
[cloud](Cloud_architecture.png)

# diagram of virtual netwokring trying to implement

```
------------------------------------------------------------------
|       vnet 10.0.0.0/16 = 65,000 addresses                      |
------------------------------------------------------------------
|        |   public-subnet   |    |    private subnet  |         |
|        |   10.0.2.0/24     |    |   10.0.3.0/24      |         |
|        |   (256 addresses) |    |   (256 adresses)   |         |
|        ---------------------    ----------------------         |
|        |       | vm |      |    |        | vm |      |         |
|        |       ------      |    |        ------      |         |
|        ---------------------    ----------------------         |
------------------------------------------------------------------
```


* create vnet with 2 subnets and have a vm in both
# Steps we took to make vnet
1. Search for create Vnet
2. Set the name of subscription and resource group
3. Set the virtual networking name (e.g tech264-..)
4. Region : (Europe)Uk South
5. Check Security 
6. IP addresses 
- add subsets and set their IP address range(only IPv4) (e.g 10.0.0.0/16): 
  - name
  - starting address
  - size
7. choose to make defualt subnet a public one with range of 10.0.2.0/24
8. make private subnet with 10.0.3.0/24
9. Tags :
   - Name : Owner
   - Value : My name

10. Review + create   
11. Click create
12. 

plan to create a VM:
* Virtual network + subnet
* Name
* Location + pricing
* Size + pricing
* storage + pricing
* OS + pricing
* SSH key pair
# How to Create a Virtual Machine (VM)
 
## Basics
1. **Search** for Virtual Machine on the Azure Portal. Create a new VM.
2. **Assign** resource group `(tech264)`.
3. **Name** the VM (e.g tech264-name...)
4. Set **region** to `(Europe) UK South`.
5. Change **availability** to "No infrastructure redudancy required".
6. Change **image** to the OS we want on the disc (Also includes flavour and version of the OS, with stuff installed and ready to run - Basically a snapshot of a system). In our case, select `Ubuntu Pro 18.04 - x64 Gen2`. If it is not visible in the immediate recent, click "See all images" and search for it.
7. Change **security type** to standard.
8. Change **size** to `Standard_Bs1 - 1 vcpu, 1 GiB memory`. Select "see all sizes" if not seen in immediate recent.
9. Change **username** to to something more secure.
10. Change SSH public key source to `Use existing key stored in Azure`.
11. Select **your** Stored key (e.g tech264..).
12. Select `HTTP (80)` under **select inbound ports**. Both `SHH (22)` and `HTTP (80)` should be selected. You need to set up a certificate to use `HHTPS (443)`.
 
## --> Disks
1. Change OS Disk type to `Standard SSD (locally redundant storage)`.
 
## --> Networking
1. Change the **virtual network** to your own one, as it will default alphabetically.
2. Change **subnet** to `public-subnet`.
3. Enable **Delete public IP and NIC when VM is deleted**. Automates this just in case you forget to do it yourself.
 
## --> Tags
1. Select `Owner : (your name)`.
 
## --> Review and Create
1. Make sure all your details are correct.

# Connecting Your Virtual Machine
1. **Start** your virtual machine.
2. Navigate to "Connect" under your VM.
3. Find "Native SSH" and **select** it. A side panel should open.
4. Input `~/.ssh/` and your `private key name` into the "Copy and Execute SSH Command" line. This will output a command for us to use in our CL (We are using **GitBash**).
5. Click the copy button for the code below what was just inputted.
6. Paste this code into your **GitBash**.
7. A **warning** will come out once entered into your **GitBash**. Respond with `yes` and then it will permanently save the IP address, meaning we will not be given the warning again.
8. You can type `exit` to **logout** of the Virtual Machine.


# linux usage
* many different distributions of linux, 