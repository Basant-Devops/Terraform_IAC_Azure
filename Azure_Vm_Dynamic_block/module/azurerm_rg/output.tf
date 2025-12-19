# output "rg_ids" {
#   description = "The IDs of the Resource Groups"
#   value       = { for rg_key, rg in azurerm_resource_group.rgs : rg_key => rg.id }
# }