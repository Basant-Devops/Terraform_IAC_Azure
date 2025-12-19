resource "azurerm_virtual_network" "virtual_network" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.address_space
}

output "virtual_network_name" {
  value = azurerm_virtual_network.virtual_network.name
  
}