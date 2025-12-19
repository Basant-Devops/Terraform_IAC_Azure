variable "resource_group" {
  type = map(object({
    rg_name   = string
    location = string
  }))
}

variable "virtual_network" {
    type = map(object({
    name                = string
    location            = string
    rg_name             = string
    address_space       = list(string)
    tags                = optional(map(string))
    subnets = optional(list(object({
      name             = string
      address_prefixes = list(string)
    })),[])
  }))
  
}
variable "demosubnet" {
  type = map(object({
    name                     = string
    rg_name                  = string
    vnet_name                = string
    address_prefixes         = list(string)
  }))       
  
}

variable "azpip" {
  type = map(object({
    name                     = string
    location                 = string
    rg_name                  = string
  }))
}

variable "network_interfaces" {
 type = map(object({
   name          = string
   location      = string
   rg_name       = string
   public_ip_id  = optional(string)
   subnet_id     = optional(string)
 })) 
}

variable "genvm" {
  type = map(object({
    name = string
    location = string
    rg_name = string
    vm_size = string
    nic_ids = optional(list(string))
    admin_username = string
    admin_password = optional(string)

  }))
}