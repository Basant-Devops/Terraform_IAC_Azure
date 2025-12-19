module "resource_group" {
  source   = "../Child VM/Resource group"
  rg_name  = "todo_rg_speed"
  location = "eastus"
}

module "vnet" {
  source     = "../Child VM/VNET"
  vnet_name  = "todo_vnet_speed"
  location   = "eastus"
  rg_name    = "todo_rg_speed"
  depends_on = [module.resource_group]
}

module "frontend_subnet" {
  source           = "../Child VM/Subnet"
  subnet_name      = "frontend"
  vnet_name        = "todo_vnet_speed"
  rg_name          = "todo_rg_speed"
  address_prefixes = ["10.0.0.0/24"]
  depends_on       = [module.vnet, module.resource_group]

}

module "backend_subnet" {
  source           = "../Child VM/Subnet"
  subnet_name      = "backend"
  vnet_name        = "todo_vnet_speed"
  rg_name          = "todo_rg_speed"
  address_prefixes = ["10.0.1.0/24"]
  depends_on = [module.vnet, module.resource_group]

}

module "nsg_frontend" {
  source             = "../Child VM/Azurerm_NSG"
  nsg_name           = "infra-morning-frontend-nsg"
  rg_name            = "todo_rg_speed"
  location           = "eastus"
  security_rule_name = "Allow-HTTP"
  depends_on = [ module.resource_group ]
}


module "nsg_backend" {
  source             = "../Child VM/Azurerm_NSG"
  nsg_name           = "infra-morning-backend-nsg"
  rg_name            = "todo_rg_speed"
  location           = "eastus"
  security_rule_name = "Allow-HTTP"
  depends_on = [ module.resource_group ]
}


module "public_ip1" {
  source   = "../Child VM/Public IP"
  rg_name  = "todo_rg_speed"
  location = "eastus"
  pip_name = "frontend-ip"
  depends_on = [ module.resource_group ]

}

module "public_ip2" {
  source   = "../Child VM/Public IP"
  rg_name  = "todo_rg_speed"
  location = "eastus"
  pip_name = "backend-ip"
   depends_on = [ module.resource_group ]
}

module "key_vault" {
  source        = "../Child VM/azure_keyvault"
  keyvault_name = "keyvault-speed"
  rg_name       = "todo_rg_speed"
  location      = "eastus"
 depends_on = [ module.resource_group ]
}

module "key_vault_secret_vm_username" {
  source        = "../Child VM/Azure_secret"
  keyvault_name =  "keyvault-speed"
  rg_name       = "todo_rg_speed"
  location      = "eastus"
  secret_name   = "ownername"
  secret_value  = var.vm_id_secret
  depends_on    = [module.resource_group, module.key_vault]
}

module "key_vault_secret_vm_password" {
  source        = "../Child VM/Azure_secret"
  keyvault_name = "keyvault-speed"
  rg_name       = "todo_rg_speed"
  location      = "eastus"
  secret_name   = "ownerpassword"
  secret_value  = var.vm_password_secret
  depends_on    = [module.resource_group, module.key_vault]
}

module "key_vault_secret_sql_username" {
  source        = "../Child VM/Azure_secret"
  keyvault_name =  "keyvault-speed"
  rg_name       = "todo_rg_speed"
  location      = "eastus"
  secret_name   = "sql_name"
  secret_value  = var.sql_id_secret
  depends_on    = [module.resource_group, module.key_vault]
}

module "key_vault_secret_sql_password" {
  source        = "../Child VM/Azure_secret"
  keyvault_name = "keyvault-speed"
  rg_name       = "todo_rg_speed"
  location      = "eastus"
  secret_name   = "sql_password"
  secret_value  = var.sql_password_secret
  depends_on    = [module.resource_group, module.key_vault]
}

module "frontend_vm" {
  source                       = "../Child VM/vm module"
  vm_name                      = "frontend-vm"
  rg_name                      = "todo_rg_speed"
  location                     = "eastus"
  vm_size                      = "Standard_D2s_v3"
  os_image_publisher           = "Canonical"
  os_image_offer               = "0001-com-ubuntu-server-jammy"
  os_image_sku                 = "22_04-lts"
  nic_name                     = "frontend-nic"
  ip_config_name               = "frontend-ip-config"
  admin_username               = "ownername"
  admin_password_name          = "ownerpassword"
  os_disk_storage_account_type = "Standard_LRS"
  keyvault_name                = "keyvault-speed"
  vnet_name                    = "todo_vnet_speed"
  pip_name                     = "frontend-ip"
  subnet_name                  = "frontend"
  depends_on                   = [module.frontend_subnet, module.public_ip1, module.key_vault_secret_vm_username, module.key_vault_secret_vm_password, module.nsg_frontend]
}

module "backend_vm" {
  source                       = "../Child VM/vm module"
  vm_name                      = "backend-vm"
  rg_name                      = "todo_rg_speed"
  location                     = "eastus"
  vm_size                      = "Standard_D2s_v3"
  os_image_publisher           = "Canonical"
  os_image_offer               = "0001-com-ubuntu-server-jammy"
  os_image_sku                 = "22_04-lts"
  nic_name                     = "backend-nic"
  ip_config_name               = "backend-ip-config"
  admin_username               = "ownername"
  admin_password_name          = "ownerpassword"
  os_disk_storage_account_type = "Standard_LRS"
  keyvault_name                = "keyvault-speed"
  vnet_name                    = "todo_vnet_speed"
  pip_name                     = "backend-ip"
  subnet_name                  = "backend"
  depends_on                   = [module.backend_subnet, module.public_ip2, module.key_vault_secret_vm_username, module.key_vault_secret_vm_password, module.nsg_backend]
}

module "named_sql_server" {
  source              = "../Child VM/azurerm_sql_server"
  sql_server_name     = "sql-server-speed"
  rg_name             = "todo_rg_speed"
  location            = "eastus"
  sql_username        = "sql_name"
  sql_password_name   = "sqlpassword"
  keyvault_name       = "keyvault-speed"
  depends_on          = [module.key_vault_secret_vm_username, module.key_vault_secret_vm_password, module.key_vault]
  
}

module "sql_database" {
source = "../Child VM/sql_DB"
  sql_server_name = "sql-server-speed"
  rg_name         = "todo_rg_speed"
  sql_database_name = "todo-sql-db-speed"
  depends_on      = [module.named_sql_server]
  
}
