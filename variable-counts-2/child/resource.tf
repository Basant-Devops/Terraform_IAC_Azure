resource "azurerm_resource_group" "child" {
    count = 4
    name = var.resource_group_name[count.index]
    location = var.location
}

