resource "azurerm_resource_group" "Lbrg" {
  name     = var.rg_name
  location = var.location
}

variable "rg_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string   
}
variable "location" {
  description = "The Azure region where the resource group will be created."
  type        = string
}

output "rg_name" {
  description = "The name of the resource group."
  value       = azurerm_resource_group.Lbrg.name
}

output "location" {
  description = "The location of the resource group."
  value       = azurerm_resource_group.Lbrg.location
}
