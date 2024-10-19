# Blob storage 

- [Blob storage](#blob-storage)
  - [***Creating a Blob Storage VM***](#creating-a-blob-storage-vm)
  - [***Making your blob storage file public***](#making-your-blob-storage-file-public)
    - [***Check the Blob on the Azure Portal***](#check-the-blob-on-the-azure-portal)
    - [***To make it public***](#to-make-it-public)
- [Downloading and logging into Azure CLI](#downloading-and-logging-into-azure-cli)
- [Diagram of structure](#diagram-of-structure)
- [Script](#script)

## ***Creating a Blob Storage VM***
1. Create a VM using our app image named ***`tech264-raiyan-blob-storage`*** and the instructions here[Create a VM](/tech264-cloud-linux/cloud/create_virtual_machine.md), then add the [run app script](/tech264-cloud-linux/scripting/run-app-only.sh) to user data when creating your VM (dont need the DB_HOST env variable as we are not running/creating a database VM)
2. SSH into the VM using these instructions [SSHing into a VM](/tech264-cloud-linux/cloud/create_SSH_key.md)
3. Download and run the Azure CLI to create a blob storage account and test container here [Azure CLI](/tech264-cloud-linux/cloud/azure/README.md)
---
## ***Making your blob storage file public***
### ***Check the Blob on the Azure Portal***
- Go through your storage account: Azure Portal > ***`tech264raiyanstorage`*** > Data storage > Containers > ***`testcontainer`*** > ***`newname.txt`*** > copy the URL. It should be **private**
 
### ***To make it public***
- Were going to change the access level to make it public
- Go to storage account
- (on the left) Settings > Configuration > Allow Blob anonymous access (enable) > click save

# Downloading and logging into Azure CLI
 
1. Insert `curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash` while SSH'd into your VM. This will **download** CLI.
2. Insert `az login`. It will ask you to go to a link and **sign in** via a web browser, giving it the **code** to authenticate. The **code** will be in this same yellow line as the link.
3. **Insert** the code on the browser input and select your account.
4. Once signed in, close the window and **return** to your VM console.
5. **Enter** the number for the subscription you wish to use.
6. Insert `az group list`. This prints out some data regarding the current resource group you reside in.
7. Insert `az storage account create --name tech264(name)storage --resource-group tech264 --location uksouth --sku Standard_LRS` to create a storage account. This will print out all the details in JSON format when successful.
8. Insert `az storage account list --resource-group tech264 --query "[].{Name:name, Location:location, Kind:kind}" --output table` to see it all in table format for readability.
9. Insert the following to create a storage container:
``` bash
az storage container create \
    --account-name tech264raiyanstorage \
    --name testcontainer
```
The `\` can be used to break up commands to have it be multiple lines for readability.
 
*You may see a yellow line warning, but fear not! It will create the container anyway. We could add `--auth-mode login` to the end of the command to prevent this!*
 
10. We can double check that we've made it by listing the containers in the storage account using:
``` bash
az storage container list \
    --account-name tech264(name)storage \
    --output table \
    --auth-mode login
```

# Diagram of structure
![diagram](/images/blob_storage.png)

# Script
[Script](/script_reference/6_0_blob_storage_script.sh)