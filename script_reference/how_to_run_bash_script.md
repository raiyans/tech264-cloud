## nginx install

- systemctl: This is the command used to control and interact with the systemd system and service manager, which manages services on Linux systems.

```bash 
sudo apt install nginx -y
sudo systemctl status nginx
sudo systemctl restart nginx
sudo systemctl enable nginx
```

## steps to provision nginx
 
1. use `nano provision.sh` to begin creating your `provision.sh` file, which will host the script.
2. In the nano interface, write the following lines (be sure to write comments using `#` to help with understanding):
   1. `#!/bin/bash`, which i called "**shebang**". This specifies which interpreter should be used to execute the script - so this tells it to use the **Bash** script.
   2. `sudo apt update -y`
   3. `sudo apt upgrade -y`
   4. `sudo apt install -y nginx`
   5. `sudo systemctl restart nginx`
   6. `sudo systemctl enable nginx`
3. Save the script by clicking `CTRL+S`, then exit the script by clicking `CTRL+X` to return back to your regular linux CL.
4. Since the default **permissions** do not allow you to execute the script, use `chmod +x provision_nginx.sh` to add **execution** **permissions** to the file.
5. Run the script using `./provision.sh`.

**notes**
* if the script starts and theres an error then it depends on wether the command executed gives an error output or something else to stop the script from running more