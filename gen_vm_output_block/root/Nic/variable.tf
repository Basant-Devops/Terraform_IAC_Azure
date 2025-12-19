variable "network_interfaces" {
 type = map(object({
   name          = string
   location      = string
   rg_name       = string
   subnet_id     = optional(string)
   public_ip_id  = optional(string)

 })) 
}

