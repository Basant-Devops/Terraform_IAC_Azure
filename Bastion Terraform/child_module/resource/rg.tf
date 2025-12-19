resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
}

output "rg_name" {
  value = azurerm_resource_group.rg.name
}

output "rg_location" {
  value = azurerm_resource_group.rg.location
}

variable "name" {}
variable "location" {}