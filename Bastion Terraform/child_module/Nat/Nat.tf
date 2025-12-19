#  Public IP banaye
resource "azurerm_public_ip" "nat_pip" {
  name                = "${var.name}-nat-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}
# NAT Gateway resource banaye
resource "azurerm_nat_gateway" "nat" {
  name                = "${var.name}-nat"
  location            = var.location
  resource_group_name = var.rg_name
  sku_name            = "Standard"
}
# internal dependency is used here from public IP resource
resource "azurerm_nat_gateway_public_ip_association" "example" {
  nat_gateway_id       = azurerm_nat_gateway.nat.id
  public_ip_address_id = azurerm_public_ip.nat_pip.id
}
# NAT Gateway ko subnet se attach karein
resource "azurerm_subnet_nat_gateway_association" "nat_assoc" {
  subnet_id      = var.subnet_id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}

#Network Security Group (NSG) me rules set karein

#NAT Gateway internet access deta hai, par NSG rules se incoming/outgoing traffic ko control kar sakte ho.

#Example: Outbound internet traffic allow karne ke liye
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.name}-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "Allow-Internet-Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }

}

# NSG ko subnet ya NIC se associate karo
resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


variable "name" { }
variable "location" { }
variable "rg_name" { }
variable "subnet_id" { }
