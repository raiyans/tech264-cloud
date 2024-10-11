Architecure for an azure vm scale sets


blob storage- virtual hard disk file custom image to t -> create vm


custome (scaleset) autoscaler:
cpu:75%, min=2, default=2, max=3 


makes 3rd if needed all vms are in its own zones sharing the 1 subnet 


need a load blancer