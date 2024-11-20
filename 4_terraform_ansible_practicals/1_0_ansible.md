# Steps for Ansible Architecture

- [Steps for Ansible Architecture](#steps-for-ansible-architecture)
  - [1. Create Two Instances on AWS](#1-create-two-instances-on-aws)
    - [Diagraam](#diagraam)
    - [Ansible Controller Instance:](#ansible-controller-instance)
    - [Ansible Target Node Instance (will run the app):](#ansible-target-node-instance-will-run-the-app)
  - [2. Connect to Instances](#2-connect-to-instances)
  - [3. Set Up Ansible on the Controller Instance](#3-set-up-ansible-on-the-controller-instance)
  - [4. Configure Ansible Hosts](#4-configure-ansible-hosts)
  - [5. Create and Run an Ansible Playbook to Install NGINX](#5-create-and-run-an-ansible-playbook-to-install-nginx)


## 1. Create Two Instances on AWS
### Diagraam


### Ansible Controller Instance:
- **Name**: `tech2xx-raiyan-ubuntu-2204-ansible-controller`
- **Security Group**: Allow SSH port
- **Key Pair**: Use the key pair you typically use for AWS instances
- **Image**: Ubuntu Server 22.04 LTS (free tier eligible)
- **Additional Setup**: Leave user data and scripts blank; do not run any.

### Ansible Target Node Instance (will run the app):
- **Name**: `tech2xx-raiyan-ubuntu-2204-ansible-target-node-app`
- **Security Group**: Allow SSH, HTTP, and port 3000 (typical for app)
- **Key Pair**: Use the same key pair as for the controller instance
- **Image**: Ubuntu Server 22.04 LTS (free tier eligible)
- **Additional Setup**: Leave user data and scripts blank; do not run any.

---

## 2. Connect to Instances

Check that you can SSH into both instances (using Git Bash is recommended).

Update and upgrade each VM:

```bash
sudo apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
```

---

## 3. Set Up Ansible on the Controller Instance

On the **Controller instance**, run the following commands to install Ansible:

```bash
sudo apt-add-repository ppa:ansible/ansible
sudo apt install ansible -y
```

Place the AWS private key in the `.ssh` folder on the **Controller VM**.

---

## 4. Configure Ansible Hosts

1. Use the ping module to verify that the Ansible controller can communicate with a device specified in the hosts file.

   !

2. Open the `hosts` file in the `/etc/ansible/` directory with nano and add the **Target Node**'s public IP address.

   ```bash
   sudo nano /etc/ansible/hosts
   ```

3. **Ping all hosts** in the `hosts` file with this command:

   ```bash
   ansible all -m ping
   ```

   - Use `all` to target every device in the `hosts` file, or specify a particular server or group.
   - Group your servers (e.g., `db` and `app`) with a parent `[test:children]` section in the hosts file.

   !

---

## 5. Create and Run an Ansible Playbook to Install NGINX

To create a YAML playbook for NGINX installation:

1. Open a new file:

   ```bash
   sudo nano install_nginx.yml
   ```

2. Use the following playbook content:
``` yaml
---
# Name of the play
- name: install nginx play
  # Where - on which devices - run this playbook
  hosts: web

  # Get comprehensive facts on the hosts / devices
  gather_facts: yes # If you want the playbook to run faster, turn this off using "no"

  # Do we need to provide admin access? Use sudo
  become: true

  # Instructions for this play, known as "tasks"
  # First Task: Install nginx on the Target Node
  tasks:
  - name: install and configure nginx
    # Use "nginx" package // "state=present" means we need it running
    apt: pkg=nginx state=present
```

3. Run the playbook:

   ```bash
   ansible-playbook install_nginx.yml
   ```