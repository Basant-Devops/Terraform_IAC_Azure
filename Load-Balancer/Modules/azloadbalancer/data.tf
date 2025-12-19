data "azurerm_public_ip" "azdatapip" {
  name                = "TestPublicIP"
  resource_group_name = var.rg_name
}
