resource "azurerm_network_interface" "network_interface" {
  for_each            = var.network_interfaces
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     =  each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
     public_ip_address_id          = each.value.public_ip_id
  }
}

output "nic_ids" {
  description = "List of Network Interface IDs"
  value       = { for key, ni in azurerm_network_interface.network_interface : key => ni.id }
}