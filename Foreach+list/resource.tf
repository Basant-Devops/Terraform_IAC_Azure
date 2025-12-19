resource "azurerm_resource_group" "child" {
    for_each = var.resource_group_name
    name = each.key
    location = each.value
}
