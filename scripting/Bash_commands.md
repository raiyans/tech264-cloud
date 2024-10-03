       #cheatsheet #linux  #cloud

- [Finding out info for a bash command](#finding-out-info-for-a-bash-command)
- [Working in linux](#working-in-linux)
  - [Advanced Package Tool](#advanced-package-tool)
  - [updating packages list](#updating-packages-list)
  - [upgrading packages (potential break)](#upgrading-packages-potential-break)
  - [how to become superuser for multi cmds](#how-to-become-superuser-for-multi-cmds)
  - [login as root user now](#login-as-root-user-now)
- [Navigation:](#navigation)
  - [Command:  ls](#command--ls)
    - [common flag meaning](#common-flag-meaning)
  - [Command:  uname](#command--uname)
  - [Command: whoami](#command-whoami)
  - [Command:  whereis](#command--whereis)
  - [Command:  which](#command--which)
  - [Command:  find](#command--find)
- [TEXT AND FILE MANIPULATION](#text-and-file-manipulation)
  - [Command:  mkdir](#command--mkdir)
  - [Command:  mv](#command--mv)
  - [Command:  cp](#command--cp)
  - [Command:  rm](#command--rm)
  - [Command:  rmdir](#command--rmdir)
  - [Command:  file](#command--file)
  - [Command:  cat](#command--cat)
  - [Command:  head](#command--head)
  - [Command:  tail](#command--tail)
  - [Command:  nl](#command--nl)
  - [Command:  more and less](#command--more-and-less)
  - [Command: grep](#command-grep)
  - [Command: df](#command-df)
  - [Command: du](#command-du)
- [ENVIRONMENT VARIABLE CONTROLS](#environment-variable-controls)
  - [Command: env](#command-env)
  - [Command: echo](#command-echo)
  - [Command: export](#command-export)
- [REDIRECTION](#redirection)
  - [Command: \>](#command-)
  - [Command: \>\>](#command--1)
  - [redirect standard errors to an output](#redirect-standard-errors-to-an-output)
  - [combining files](#combining-files)
- [PIPELINES](#pipelines)
- [Modify file permissions](#modify-file-permissions)
  - [reading permissions](#reading-permissions)
  - [Command: chown](#command-chown)
  - [Command: chgrp](#command-chgrp)
  - [Command: chmod](#command-chmod)
- [Network commands](#network-commands)
  - [Command: ifconfig](#command-ifconfig)
  - [Command: ping](#command-ping)
  - [Command: traceroute](#command-traceroute)
  - [Command: ssh](#command-ssh)
  - [Command: hostname](#command-hostname)
- [Processes](#processes)
  - [Command: process](#command-process)
  - [Command: kill](#command-kill)
  - [Command: top](#command-top)
  - [Command: sleep](#command-sleep)
  - [Command: jobs](#command-jobs)
  - [Command: systemctl](#command-systemctl)
- [Other commands](#other-commands)
  - [Command: history](#command-history)
  - [Command: ssh-copy-id](#command-ssh-copy-id)
- [BASH SCRIPTING](#bash-scripting)
  - [Make an executable command from your bash script](#make-an-executable-command-from-your-bash-script)
- [VARIABLES IN BASH](#variables-in-bash)
  - [Variables in bash](#variables-in-bash-1)
  - [Environment variable stored in bash](#environment-variable-stored-in-bash)
    - [Make environment variable Persistent](#make-environment-variable-persistent)
  - [Single vs double quotes](#single-vs-double-quotes)
  - [Constants](#constants)
  - [Doing maths](#doing-maths)
- [Conditional statement](#conditional-statement)
  - [Command: read](#command-read)
- [case statements](#case-statements)
- [Functions](#functions)
- [Loops](#loops)


# Finding out info for a bash command

descriptions and flags found using the commands for help and manual
> Examplecmd --help
> man Examplecmd

TODO: check how to use pushd and popd for advanced navigating 

# Working in linux 
Root in linux is the super user
dont use sudo every command - sudo is super use command temporarily
## Advanced Package Tool
**What is APT?**  
* Collection of tools used to install, update, remove, and otherwise manage software packages on Debian
* The Debian project maintains an official repository holding thousands of software packages which APT users can install via the apt command-line program and a network connection. Users can also install packages from third-party repositories as well as locally-stored repositories.
## updating packages list
> sudo apt update -y

why do we need to update everytime?
## upgrading packages (potential break)
this is where linux system can break because of package versions not being compatible
> sudo apt upgrade -y

## how to become superuser for multi cmds
Command below goes to the top of your directory with the os related files here, this is the root directory
> cd /

## login as root user now
> sudo su

you should see your hostname shange to `root` and then to exit out of su('root') just enter `exit`  in terminal at the end

# Navigation: 
full stop means current directory `/.`

cd with a space in file/folder name 
> cd my\ pictures

## Command:  ls

displays only files with letters s with wildcard:
> ls s* 

return back results with more than one letter with a character set combined with wildcard:
> ls [cs]* 

return back with same file type:
> ls *.md 

use "?" for any character in a search. example returns and file name with 2 character extensions like .md or .js:
>  ls *.?? 

Used for finding anything with a capital letter:
> ls [\[:uppper:]]*

Same for anything lower case
> ls [\[:lower:]]* 
### common flag meaning
`-l` usually means long format

## Command:  uname
tells us what the os is
> uname

## Command: whoami
wha the host name is 
> whoami

## Command:  whereis

Locate the binary, source, and manual-page files for a command.
> whereis bash

## Command:  which

Only  returns  the  pathnames of the files (or links) which would be executed in the current environment
> which bash

## Command:  find

search for files in a directory

> find . -name \*.md

> find /home -name file.txt


# TEXT AND FILE MANIPULATION
## Command:  mkdir
just make a new directory(folder)

example where parent folder doesnt exist
> mkdir -p newFolder/Subfolder

## Command:  mv 
move files and **rename files**
> project1/file.txt newFolder/Subfolder

## Command:  cp 
copy files over
> cp project02/file.txt project01/file01.txt

## Command:  rm 
delete file or files
> rm file01.txt
> rm \*.md

## Command:  rmdir
delete directories. Without args/wildcards, it will delete the last folder in the pathname given
> rmdir sub1/sub2

## Command:  file
> file example.txt

## Command:  cat
stands for concatenate although can be used as a print line tool on the terminal
> cat quotes01.txt 
> cat quotes01.txt quotes02.txt 


## Command:  head
shows the first 10 lines instead of everything very useful tip
> head longOutput001.log

Use -n to choose how many lines you want to print out 
>head -n 3 fake001.log 

## Command:  tail
shows the last 10 lines instead of everything
> tail longOutput001.log

## Command:  nl
prints the text with number of line on each line
> nl longOutput001.log

## Command:  more and less
lets you navigate the textfiles

less lets you scroll with spacebar and b 
and use search params

## Command: grep 
to parse though and match a result in a text file 
> grep "123.26.119.140" fake002.log

## Command: df 
The `df` = "disk-free," and shows available and used disk space on system
> df -h -a

-h human-readable format
-a shows the file system's complete disk usage even if the Available field is 0
`df -T` shows the disk usage along with each block's filesystem type (e.g., xfs, ext2, ext3, btrfs, etc.)
`df -i` shows used and free inodes

## Command: du
shows the disk usage of files, folders, etc. in the default kilobyte size
> du -h -a -s
# ENVIRONMENT VARIABLE CONTROLS
## Command: env 
Set each NAME to VALUE in the environment and run COMMAND.

## Command: echo 
prints the value of the variable 
to print variable value you will need to start with "$" to access the values 
some useful examples for any new instances:
> echo $SHELL
> echo $HOME
> echo $USER

Super useful to find location of executables which will need to be updated when a new program is added. like a new CLI, this will help the system locate the binary to use the cli command:
> echo $PATH 


## Command: export 
create environment/shell values:
> export newVar=value

"newVar" is only available in that terminal session that it is created in, they do not persist in new sessions

global configuration would solve this issue under: "/etc/profile"
It would effect every user logged in the machine

".profile",".bashrc" files can be edited and will be loaded into every different session
would be a different effect for every user in a machine



# REDIRECTION 

## Command: >
The command is redirecting the output into the file name give. if it does not exist it will create the file 
> ls-l > outputfile.txt
> echo "this is some strings2" > raiyansoutput.txt

## Command: >> 
This command redirects and appends the file with output instead of always overwriting like the above.
> ls-l >> outputfile1.txt

## redirect standard errors to an output

the same command to redirect(>) can do so for standard errors like below 

> ls -l ./dir > error.txt 2>&1

is the same as 

> ls -l &> output2.txt

TODO: not sure why the 2and &1 is needed with the redirect command. it isnt working without it. looks like its something about redirecting stream 2 into 1. need more info aboiut i/o streams

## combining files 

using cat command again we can now use it for combining different files. this example shows 2 text files concatenated and the its output redirected to file name paragraph.txt. insanely useful for automating and scripting.
> cat part1.txt part2.txt > paragraph.txt

# PIPELINES

Sometimes you don't want the command to push output into a different file. pipelines will help to push your outputs into another command using pipelines.

below this will pollute your terminal with a large out of all the file names. a common way to have a nicer view is to pipeline the out into the less command
>ls -l /usr/bin
>ls -l /usr/bin | less

another common example is searching through the directory :
>ls -l /usr/bin | grep echo

and pipe it to even another command after:
>ls -l /usr/bin | grep echo | sort

print just the first line alternative with pipeline example:
> cat part1.txt | head -n 1


# Modify file permissions 

[deeper_infomations](linux_file_ownership_and_permission.md)

## reading permissions
running the line "ls -l" will show you the permissions with output like this:
> -rw-rw-rw-  1 vscode root 3070 Sep  7 14:31 README.md

(-rw) first 3 tell me if it a file or directory (- or d) with wr being the users read/write permissions 
(-rw) characters 3-6 tell me the same but for group instead of user
(rw-) the others permissions 

(1) number of linked hard links

(vscode) the user
(root) the group

(3070) size of the file
(Sep  7 14:31 ) date modified
(README.md) The file name

## Command: chown 
changes the permission of any file with another setting
this example is only changing the user permission:
> sudo chown root newFile.txt

to change the permision of the group with semi colon
> sudo chown :root newFile.txt

## Command: chgrp
change the group ownership
> chgrp vscode newFile.txt

## Command: chmod
change the read/write permission 
This example makes my script.sh executabkle in all the permission types
> chmod +x script.sh

you can write all the permissions with octal numbers instead r=4 w=2 x=1:
> chmod 664 script.sh

# Network commands 
## Command: ifconfig
used to view and change the configuration of the network interfaces on your system. displays information about all network interfaces currently in operation. like LAN
> ifconfig

## Command: ping
check connectivity between devices on your LAN or even between devices outside your LAN.
the `-c` option, which will allow you to specify the number of packets to request from a given source.
> ping -c 5 google.com

## Command: traceroute

## Command: ssh
connection can also be used for terminal access, file transfers, and for tunneling other applications.
> ssh alternative-username@sample.ssh.com

## Command: hostname
The **hostname** is what a device is called on a network. The hostname is used to distinguish devices within a local network.
this command will display the IP address(es) assigned to your
>hostname -I

# Processes
## Command: process
process associated with a terminal session can be found with the command below 
> ps -p $$
>
the command usually shows user processes that we have run 
tty column has the id values of which bash terminal process is runing from lets you identify which bash session they are runing on

to see all system processes and extended info
> ps aux

every process after process 1 has a parent process meaning they were all started by another process. like a chain 

## Command: kill
to kill a process with differernt levels there are 64 levels -1 to -64 the different strengths are not based on number order 
hangup signal =  `kill -1 2512` 2512 is a 'process id' in this example
terminate = `kill 2512` deafult signal level here is 15 
brute force = `kill -9 2512` 

harsher kills could cause zombie processes if parent processes are killed without a graceful shutdown for child processes 

## Command: top
its like a task manager view that shows processes and cpu
orders by the most cpu usasge at top
shift m order by memory at top
shift n order by newest process at top

## Command: sleep
gives a delay `sleep 3` will pause for 3 seconds
`sleep 5000 &` will give use a process id and run in the background

## Command: jobs
can show the process in the background
`jobs -l` for more info

## Command: systemctl
systemctl: This is the command used to control and interact with the systemd system and service manager, which manages services on Linux systems.
`systemctl restart nginx`

# Other commands

## Command: history
showws a list of cmds you ran in linux, stored in the bash.
> history
cmd below will clear history
> history -c 

## Command: ssh-copy-id
`ssh-copy-id` installs an [SSH key](https://www.ssh.com/ssh/key/) on a server as an authorized key.
> ssh-copy-id -i ~/.ssh/mykey user@host
# BASH SCRIPTING
Start writing the bash commands in an executabkle file with can be saved and shared for later uses.

when creating a bash script start the file at the top with a shebang (#!)
The line tells the environment that we are in, what interpreter to use. In this example it is going to be bash:
>#!/bin/bash

comments in bash are just a hashtag(#)

Once you make a script you can move it to a directory in your $PATH variable 

## Make an executable command from your bash script

1. looking for a path executables 
   >$ echo $PATH
   >
/vscode/bin/linux-x64/8b617bd08fd9e3fc94d14adb8d358b56e3f72314/bin/remote-cli:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/vscode/.local/bin

2. I can see "/home/vscode/.local/bin" is a possible option. create the directories if it doesn't exist
>mkdir -p /home/vscode/.local/bin

3.  Now I can paste the script in the directory and run it directly as a command in my terminal 
> $ cp hello_world /home/vscode/.local/bin
> $ hello_world 
> Hello World!

# VARIABLES IN BASH

## Variables in bash 

> hello_message='Hello Worlds!'
> echo $hello_message

if you want to assign the output of a command to a variable, you can in bash

> current_dir=$(pwd)
> echo $current_dir

## Environment variable stored in bash

prints out all of the env variables
> printenv

checks the single env for pwd variable
> printenv PWD 

set an env var
> export MYNAME=raiyan
> printenv MYNAME

### Make environment variable Persistent
login in sssh .bashrc file also loads in 
set env var in that file you will then have a persistent environment variable


## Single vs double quotes

To get the output with varible values shown always use double quotes
>echo "$hello_message and $current_dir"

results:Hello Worlds! and /workspaces/bash-for-beginners/what-is-a-bash-script

if you want the variable names to be printed and not computed use single quotes
>echo '$hello_message and $current_dir'

results:$hello_message and $current_dir


## Constants
immutable values that cannot be changed after being declared
> readonly variable_wont_change="blue"


## Doing maths
Arithmetic expansion allows the evaluation of an arithmetic expression and the substitution of the result. The format for arithmetic expansion is:

>$(( expression ))
>$((number % 2)) -eq 0

# Conditional statement
if statements work in the format below with if,then,else but needs to be closed with fi 

>if [ $((number % 2)) -eq 0 ];
>then
>echo "The number $number is even!";
>else
>echo "The number $number is odd!"
>fi

difference in equality checkers:
>`=` and `==` are for string comparisons  
>`-eq` is for numeric comparisons
>**_-ne_** for not equal numbers
>**_-gt** for greater than
>

## Command: read
use the command to take input. example below has -p flag for prompt and then the variable to store the input.

>read -p "Enter a number: " n

# case statements

start with case (variable) in 
and then end with case spelt backwards

>case $n in
> ???)
>echo "3 characters found";;
>1|2)
>echo "One or two found";;
>aa)
>echo "double aa found";;
>\*.txt)
>echo "a text file found";;
>*)
>echo "Other";;
>esac


# Functions

functions and variables defined before being called like c.
looks like normal format:
> myFunction () { ...enter code...}

and then call your function with a parameter like this:
> myFunction $number 

the params are called inside the function as $1 $2 $3.... for however many params you send.
$0 is reserved for the function's name when defined in the terminal. When defined in a bash script, **`$0`** returns the script's name and location.
example below will print out whatever value of $number as $1
> myFunction () { 
> echo $1
> }

if you need write variables in a function and you don't want global scope. declare variables as:
> local myNum=5


# Loops

while loops format, remember to end with done:

you can also use break keyword in the loop to stop iterating

> while [\[ ...conditional statement]];  do
> 	write a function here
> done

until loops same thing until condition is true unlike while

for loops(traditional like c#)

>services=("loadbalancer" "virtualmachine" "storage")
>for i in "${services[@]}"
>do
>echo $i
>done


for loops (newer like c)

> for (( i=0; i<5; i=i+1 )); do
> echo "The counter is at: $i"
> done

