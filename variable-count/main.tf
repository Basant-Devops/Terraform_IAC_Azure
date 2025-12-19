resource "azurerm_resource_group" "namespace" {
    count = 6
name = var.rg_name[count.index]
location = "East US"
}

