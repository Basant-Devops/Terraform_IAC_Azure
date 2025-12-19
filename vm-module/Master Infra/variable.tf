variable "vm_id_secret" {
  description = "The secret value for the VM ID"
  type        = string
  default     = "admin"
}

variable "vm_password_secret" {

  description = "The secret value for the VM password"
  type        = string
  default     = "azureguy123!"

}

variable "sql_id_secret" {
  description = "The secret value for the SQL ID"
  type        = string
  default     = "sqladmin"
  
}

variable "sql_password_secret" {
  description = "The secret value for the SQL password"
  type        = string
  default     = "sqlpassword123!"
}
