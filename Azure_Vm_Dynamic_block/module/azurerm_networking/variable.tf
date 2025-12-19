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