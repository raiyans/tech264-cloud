gracefully end proccess 



pm2 for node to stop and end processes instead of killing them everytime

get reverse proxy working


graceful shutdown will kill the child processes before the parent process and avoids zombie process 

when to use pm2 to stop a process and just kill a process?


turn userdata into a system control service



**Important**
1. Share image to Azure compute gallery
    - choose: No, capture only a managed image.
2. waagent -deprovision+user"


Architecure for an azure vm scale sets


blob storage- virtual hard disk file custom image to t -> create vm


custome (scaleset) autoscaler:
cpu:75%, min=2, default=2, max=3 


makes 3rd if needed all vms are in its own zones sharing the 1 subnet 


need a load blancer