resource "azurerm_public_ip" "bastion_ip" {
  name                = "${var.name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id  #internal dependency is used here
  }

  sku = "Standard"
}
variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
