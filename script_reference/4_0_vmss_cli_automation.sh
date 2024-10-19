# Delete a VM Scale Set using the Azure CLI
az vmss delete --name <scale-set-name> --resource-group <resource-group-name>
# Delete the associated load balancer
az network lb delete --name <load-balancer-name> --resource-group <resource-group-name>
# Delete the virtual network (if needed)
az network vnet delete --name <vnet-name> --resource-group <resource-group-name>