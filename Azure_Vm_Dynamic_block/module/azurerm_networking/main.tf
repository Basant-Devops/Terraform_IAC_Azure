resource "azurerm_virtual_network" "vnets" {
    for_each = var.vnets
    name                = each.value.name
    address_space       = each.value.address_space
    location            = each.value.location
    resource_group_name = each.value.rg_name
      dynamic "subnet" {
        for_each = each.value.subnets != null ? each.value.subnets : []
        #for_each = coalesce(each.value.subnets, [])
        content {
          name           = subnet.value.name
          address_prefixes = subnet.value.prefixes
        }

      }
}

# output "subnet_ids" {
#   value = {
#     for vnet_key, vnet in azurerm_virtual_network.vnets :
#     vnet_key => {
#       for subnet in vnet.subnet :
#       subnet.name => subnet.id
#     }
#   }
# }