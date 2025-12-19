variable "demosubnet" {
  type = map(object({
    name                     = string
    rg_name                  = string
    vnet_name                = string
    address_prefixes         = list(string)
  }))       
  
}