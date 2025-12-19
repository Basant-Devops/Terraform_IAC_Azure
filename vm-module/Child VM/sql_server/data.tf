data "azurerm_key_vault" "kv" {
  name                = var.keyvault_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault_secret" "server_id_secret" {
  name         = var.sql_username
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "server_password_secret" {
  name         = var.sql_password_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

