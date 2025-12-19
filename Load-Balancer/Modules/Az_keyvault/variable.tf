variable "rg_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string   
}
variable "location" {
  description = "The Azure region where the resource group will be created."
  type        = string
}
variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
}

