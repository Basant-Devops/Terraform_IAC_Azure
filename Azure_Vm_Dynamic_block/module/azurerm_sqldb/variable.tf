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