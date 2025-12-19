resource "azurerm_public_ip" "public-ip" {
  name                = var.pip_name
  resource_group_name = var.rg_name
    sku                 = "Standard"
  location            = var.location
  allocation_method   = "Dynamic"
}

variable "pip_name" {}
variable "rg_name" {}
variable "location" {}
