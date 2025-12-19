variable "rg_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string   
}
variable "location" {
  description = "The Azure region where the resource group will be created."
  type        = string
}
variable "pip_name" {
  description = "The name of the Public IP."
  type        = string
}

variable "allocation_method" {
  description = "The allocation method for the Public IP."
  type        = string
}