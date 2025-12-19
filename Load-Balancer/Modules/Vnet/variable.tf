variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
}

variable "virtual_network_name" {
  
}

variable "rg_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string   
}
variable "location" {
  description = "The Azure region where the resource group will be created."
  type        = string
}