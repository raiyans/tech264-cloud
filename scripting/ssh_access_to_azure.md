# steps to produce ssh key

1. navigate to root by just typing `cd`
2. find or creat `./ssh` folder
3. ` ssh-keygen -t rsa -b 4096 -C "raiyansuk@gmail.com"` to create a key
   * `-t` to choose algo
   * `-b` how many bytes
   * `-C` add username/email
4. choose file name and the password and see resulting files of private key and public key
5. `cat tech264-raiyan-az-key | pbcopy` to clipboard
6. go to ssh section to your vm and and paste key