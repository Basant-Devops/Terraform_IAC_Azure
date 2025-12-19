module "azrg" {
  source = "../module/azurerm_rg"
  resource_group = var.resource_group
}

module "azvn" {
  depends_on = [ module.azrg ]
  source = "../module/azurerm_networking"
  vnets = var.vnets
}

# output "subnet_ids" {
#   value = module.azvn.subnet_ids
# }

module "azpip" {
  depends_on = [ module.azrg ]
  source = "../module/azurerm_pip"
  public_ips = var.public_ips
}

# output "pip_ids" {
#   value = module.azpip.pip_ids
# }
module "azvm" {
  depends_on = [ module.azvn, module.azpip ]
  source = "../module/azurerm_compute"
  vms = var.vms
}

module "azsqlserver" {
  depends_on = [ module.azrg ]
  source = "../module/azurerm_sqlserver"
  server = var.server
}

module "azsqldb" {
  depends_on = [ module.azsqlserver ]
  source = "../module/azurerm_sqldb"
  database = var.database
}
