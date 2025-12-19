resource "azurerm_resource_group" "name" {
 for_each = var.rg_details
name = each.value.name
location = each.value.location
}

