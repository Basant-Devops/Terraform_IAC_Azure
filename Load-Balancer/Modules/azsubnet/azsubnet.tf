resource "azurerm_subnet" "name" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.rg_name
  address_prefixes        = ["10.0.1.0/24"]
}

output "subnet_name" {
  value = azurerm_subnet.name.name
}

output "subnet_id" {
  value = azurerm_subnet.name.id
}