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