variable "nic-name" {
  description = "The name of the network interface."
  type        = string     
}

variable "vm-name" {
  description = "The name of the virtual machine."
  type        = string     
  
}
variable "rg_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string   
}

variable "location" {
  description = "The Azure region where the resource group will be created."
  type        = string
  
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
  
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string

}

variable "admin_username" {
  description = "The admin username for the virtual machine."
  type        = string
  
}
variable "admin_password" {
  description = "The admin password for the virtual machine."
  type        = string
  sensitive   = true
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
  default     = "Standard_DS1_v2"
} 

variable "image_publisher" {
  description = "The publisher of the image to use for the virtual machine."
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "The offer of the image to use for the virtual machine."
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
  description = "The SKU of the image to use for the virtual machine."
  type        = string
  default     = "22_04-lts-gen2"
}

variable "image_version" {
  description = "The version of the image to use for the virtual machine."
  type        = string
  default     = "latest"
}

