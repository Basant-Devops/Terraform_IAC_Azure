resource "azurerm_key_vault_secret" "secret_name" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.rg_name
}

output "secret_name" {
  value = azurerm_key_vault_secret.secret_name.name
}

output "secret_value" {
  value = azurerm_key_vault_secret.secret_name.value
}