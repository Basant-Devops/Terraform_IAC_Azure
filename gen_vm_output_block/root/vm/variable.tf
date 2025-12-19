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