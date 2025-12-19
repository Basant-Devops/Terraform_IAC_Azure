resource "azurerm_subnet" "azsubnet" {
  for_each = var.demosubnet
  name                 = each.value.name
  resource_group_name  = each.value.rg_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = each.value.address_prefixes
}

output "subnet_ids" {
  value = {
    for key, subnet in azurerm_subnet.azsubnet : key => subnet.id
  }
}