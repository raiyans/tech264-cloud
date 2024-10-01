
# diagram of virtual netwokring trying to implement

```
------------------------------------------------------------------
|       vnet 10.0.0.0/16 = 65,000 addresses                      |
------------------------------------------------------------------
        |   public-subnet   |    |    private subnet  |
        |   10.0.2.0/24     |    |   10.0.3.0/24      |
        |   (256 addresses) |    |   (256 adresses)   |
        ---------------------    ----------------------
                | vm |                    | vm |
                ------                    ------
```


* create vnet with 2 subnets and have a vm in both

# cloud diagram recreated
* https://lucid.app/lucidchart/2e8e8991-8471-4bed-a4e6-10e3e2881810/edit?viewport_loc=-1087%2C-1714%2C2112%2C2469%2C0_0&invitationId=inv_54f48fdd-5e6d-4a6b-86b9-5a99b590c334
  
[cloud](scripting\Cloud_architecture.png)