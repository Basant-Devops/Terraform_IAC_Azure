resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]
}


variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string  
}

variable "location" {
  description = "The location of the virtual network."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group where the virtual network will be created."
  type        = string
}

