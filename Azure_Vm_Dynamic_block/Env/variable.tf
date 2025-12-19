variable "resource_group" {
  type = map(object({
    name     = string
    location = string
  }))
}

variable "vnets" {
    type = map(object({
    name                = string
    location            = string
    rg_name             = string
    address_space       = list(string)
    subnets = optional(list(object({
      name             = string
      prefixes = list(string)
    })),[]) #>>> Default to empty list if not provided but we have use ternary in main.tf so this is optional
  }))
}

variable "public_ips" {
    type = map(object({
        name                = string
        rg_name             = string
        location            = string
        allocation_method   = string
        tags                = optional(map(string), {} )
    }))
}
#default key 'tags' as empty map if not provided

variable "vms" {
  type = map(object({
    vmname              = string
    nicname             = string
    subnetname          = string
    pipname             = string
    vnet_name           = string
    rg_name             = string
    location            = string
    tags                = optional(map(string))
    image               = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    ip_configurations = list(object({
      confname                     = string
      private_ip_address_allocation = string
      private_ip_address            = optional(string)
      primary                       = optional(bool)
    }))
  }))
}

variable "server" {
    type = map(object({
        sql_server_name   = string
        rg_name           = string
        location          = string
        admin_username    = string
        admin_password    = string
        tags              = optional(map(string), {})
    }))
}

variable "database" {
    description = "A map of databases to create."
    type        = map(object({
        sql_db_name = string
        max_size_gb = number
        sql_server_name = string
        rg_name     = string
        tags        = optional(map(string), {})
    }))
  
}

