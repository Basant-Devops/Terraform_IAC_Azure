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

