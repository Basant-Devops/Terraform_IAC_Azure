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
