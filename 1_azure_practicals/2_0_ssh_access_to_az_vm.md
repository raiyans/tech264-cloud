# Steps to produce ssh key
- [Steps to produce ssh key](#steps-to-produce-ssh-key)
- [Steps to access vm on azure](#steps-to-access-vm-on-azure)

1. navigate to root by just typing `cd`
2. find or creat `./ssh` folder
3. ` ssh-keygen -t rsa -b 4096 -C "raiyansuk@gmail.com"` to create a key
   * `-t` to choose algo
   * `-b` how many bytes
   * `-C` add username/email
4. choose file name and the password and see resulting files of private key and public key
5. `cat tech264-raiyan-az-key | pbcopy` to clipboard
6. go to ssh section to your vm and and paste key

# Steps to access vm on azure
* vm was setup witha kay pair that we stored earlier in azure and will use that again 
1. go to vm and then go to connect section 
2. choose the native ssh option
3. locate your ssh private key and copy the path to the key
4. use the azure helper that builds a ssh command into the vm
5. `ssh -i  ~/.ssh/tech264-raiyan-az-key adminuser@20.90.162.159`
   * `~/.ssh` the tilde will be your home directory for me on windows it is`~ =/c/Users/Raiyan/`