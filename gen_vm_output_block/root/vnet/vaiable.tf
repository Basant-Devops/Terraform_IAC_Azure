variable "virtual_network" {
    type = map(object({
    name                = string
    address_space       = list(string)
    tags                = optional(map(string))
    rg_name            = string
    location           = string
     
    }))
}

