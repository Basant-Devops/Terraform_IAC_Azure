
variable "sql_username" {
  description = "The SQL server username."
  type        = string
  
}
variable "sql_password_name" {
  description = "The name of the SQL server password secret in Key Vault."
  type        = string
}

variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string
}

variable "keyvault_name" {
  description = "The name of the Key Vault."
  type        = string
  
}

variable "rg_name" {
  description = "The name of the resource group where the SQL Server will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the SQL Server will be created."
  type        = string
}