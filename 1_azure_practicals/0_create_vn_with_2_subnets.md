# Create Virtual Network and Subnet

## VN with VM's Diagram
![cloud](/images/Cloud_architecture.png)
[image source]([/images/Cloud_architecture.png](https://lucid.app/lucidchart/2e8e8991-8471-4bed-a4e6-10e3e2881810/edit?viewport_loc=-1087%2C-1714%2C2112%2C2469%2C0_0&invitationId=inv_54f48fdd-5e6d-4a6b-86b9-5a99b590c334))

## Diagram of virtual netwokring trying to implement

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


## Steps we took to make vnet
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
    
