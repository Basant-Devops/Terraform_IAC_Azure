resource "azurerm_public_ip" "pip" {
  for_each            = var.azpip
  name                = "${each.value.name}-pip"
  location            = each.value.location
  resource_group_name = each.value.rg_name
  allocation_method   =  "Static"
  sku                 = "Standard"

}

output "azpip_id" {
    value = { for k, pip in azurerm_public_ip.pip : k => pip.id }
  
}