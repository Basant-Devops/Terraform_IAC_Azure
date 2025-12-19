data "azurerm_key_vault" "kv" {
  name                = var.keyvault_name
  resource_group_name = var.rg_name
}
resource "azurerm_key_vault_secret" "secret" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = data.azurerm_key_vault.kv.id
}
variable "keyvault_name" {
  description = "The name of the Key Vault."
  type        = string
}
variable "rg_name" {
  description = "The name of the resource group."
  type        = string
}
variable "location" {
  description = "The location of the Key Vault."
  type        = string
}
variable "secret_name" {
  description = "The name of the secret to be created in the Key Vault."
  type        = string
  
}
variable "secret_value" {
  description = "The value of the secret to be stored in the Key Vault."
  type        = string
}