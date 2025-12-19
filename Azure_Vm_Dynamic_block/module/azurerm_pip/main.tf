resource "azurerm_public_ip" "public_pip" {
    for_each = var.public_ips
  name                = each.value.name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  sku                 = "Standard"

  tags = {
  environment = lookup(each.value.tags, "environment", "default")
}
}
# lookup(map, key, default) - If the key is not present in the map, the function returns the default value instead.

# output "pip_ids" {
#   value = { for k, v in azurerm_public_ip.public_pip : k => v.id }
  
# }