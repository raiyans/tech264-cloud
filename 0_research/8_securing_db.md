
# what has been done to make the database more private
### 1. Removed the Public IP Address:
   * The public IP of the database (DB VM) was removed, making it inaccessible directly from the internet. 
   * This prevents external users from attempting to connect to the database directly.

### 2. Isolated the DB in a Private Subnet:
   * The database was moved into a private subnet (10.0.4.0/24), which has no internet access. 
   * This means that only VMs within the same virtual network, such as the App VM, can communicate with the DB.

### 3. Access DB via App VM (Jump Box):
   * Instead of connecting to the DB directly, you now access the DB by first SSH-ing into the App VM (which has a public IP) and then connecting to the DB internally from the App VM. 
   * This adds an additional layer of protection.

### 4. Planned Deployment of NVA (Network Virtual Appliance):
   * A Network Virtual Appliance (NVA) was deployed in the DMZ subnet to act as a filtering gateway for any traffic heading towards the database. 
   * The NVA will ensure that only safe and legitimate traffic can reach the database, adding another layer of protection.

These steps enhance the privacy of the database by significantly reducing its exposure to the public internet and adding multiple layers of filtering and security.

  