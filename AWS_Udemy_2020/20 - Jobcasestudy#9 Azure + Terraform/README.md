Basado: https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/11140122#questions

**Demo: Weapp stack**
En este ejemplo con Azure desplegaremos una webapp compuesta de:
- 1x resource group: azurerm_resource_group
- 1x virtual network (el equivalente a VPC de Amazon): azurerm_virtual_network
- 1x security group
- 1x balanceador HTTP y sus tests
- 1x IP publica para el frontend del balanceador: azurerm_public_ip
- 2x VM
- 1x backend MySQL
