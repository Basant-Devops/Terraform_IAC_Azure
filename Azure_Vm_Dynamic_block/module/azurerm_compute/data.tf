data "azurerm_subnet" "datasubnet" {
  for_each = var.vms
  name                 = each.value.subnetname
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}
data "azurerm_public_ip" "datapip" {
  for_each = var.vms
  name                = each.value.pipname
  resource_group_name = each.value.rg_name
}

data "azurerm_key_vault" "name" {
  for_each = var.vms
  name                = each.value.kv_name
  resource_group_name = each.value.rg_name
}


# Need to create data block with same for_each key as of NICs and VMs 
# So that while creating IP configurations inside NIC we can refer to these data sources with same key


# output "nic_ids" {
#   description = "The IDs of the Network Interfaces"
#   value       = { for k, v in azurerm_network_interface.aznic : k => v.id }
# }