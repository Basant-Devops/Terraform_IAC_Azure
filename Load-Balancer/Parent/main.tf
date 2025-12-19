module "resource_group" {
  source      = "../Modules/rg_module"
  rg_name     = "LoadBalancer-RG"
  location    = "East US"
}

module "azkv" {
  depends_on = [ module.resource_group ]
  source        = "../Modules/Az_keyvault"
  key_vault_name = "LoadBalancerKeyVault"
  location      = module.resource_group.location
  rg_name       = module.resource_group.rg_name
}

module "kvsecretusername" {
  depends_on = [ module.azkv ]
  source        = "../Modules/Azkevaultsecret"
  rg_name       = module.resource_group.rg_name
  key_vault_name = module.azkv.key_vault_name
  secret_name   = "admin-username"
  secret_value  = "Azureguy"
}

module "kvsecretpassword" {
  depends_on = [ module.azkv ]
  source        = "../Modules/Azkevaultsecret"
  rg_name       = module.resource_group.rg_name
  key_vault_name = module.azkv.key_vault_name
  secret_name   = "admin-password"
  secret_value  = "ComplexP@ssword1234"
}

module "vnet" {
    depends_on = [ module.resource_group ]
    source                  = "../Modules/Vnet"
    virtual_network_name    = "LoadBalancerVnet"
    address_space           = ["10.0.0.0/16"]
    location                = module.resource_group.location
    rg_name                 = module.resource_group.rg_name
}

module "subnet" {
    depends_on = [ module.vnet ]
    source                  = "../Modules/azsubnet"
    subnet_name =   "LoadBalancerSubnet"
    rg_name         = module.resource_group.rg_name
    virtual_network_name    = module.vnet.virtual_network_name
}

module "vm1" {
  source = "../Modules/Virtual-machine"
  depends_on = [ module.subnet, module.kvsecretusername, module.kvsecretpassword ]
  nic-name        = "LoadBalancerVM1-NIC"
  vm-name         = "LoadBalancerVM1"
  location        = module.resource_group.location
  rg_name         = module.resource_group.rg_name
  admin_username  = module.kvsecretusername.secret_value
  admin_password  = module.kvsecretpassword.secret_value
  subnet_name    = module.subnet.subnet_name
  virtual_network_name = module.vnet.virtual_network_name
  vm_size         = "Standard_DS1_v2"
  image_publisher = "Canonical"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_sku       = "22_04-lts-gen2"
  image_version   = "latest"
}

module "vm2" {
  source = "../Modules/Virtual-machine"
  depends_on = [ module.subnet, module.kvsecretusername, module.kvsecretpassword ]
  nic-name        = "LoadBalancerVM2-NIC"
  vm-name         = "LoadBalancerVM2"
  location        = module.resource_group.location
  rg_name         = module.resource_group.rg_name
  admin_username  = module.kvsecretusername.secret_value
  admin_password  = module.kvsecretpassword.secret_value
  subnet_name    = module.subnet.subnet_name
  virtual_network_name = module.vnet.virtual_network_name
  vm_size         = "Standard_DS1_v2"
  image_publisher = "Canonical"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_sku       = "22_04-lts-gen2"
  image_version   = "latest"
}

module "pip" {
  depends_on = [ module.resource_group ]
  source = "../Modules/Public-ip"
  location        = module.resource_group.location
  rg_name         = module.resource_group.rg_name
  allocation_method = "Static"
  pip_name        = "LoadBalancer-PIP"
}

module "loadbalancer" {
  depends_on = [ module.pip ]
  source = "../Modules/azloadbalancer"
  rg_name         = module.resource_group.rg_name
  location        = module.resource_group.location
}

module "backend-nic1" {
  depends_on = [ module.loadbalancer, module.vm1 ]
  source = "../Modules/VmNic_lbBackend_association"
  rg_name         = module.resource_group.rg_name
  bap_name = "BackEndAddressPool"
  nic_name = module.vm1.nic-name
  lb_name = module.loadbalancer.lb_name

}

module "backend-nic2" {
  depends_on = [ module.loadbalancer, module.vm2 ]
  source = "../Modules/VmNic_lbBackend_association"
  rg_name         = module.resource_group.rg_name
  bap_name = "BackEndAddressPool"
  nic_name = module.vm2.nic-name
  lb_name = module.loadbalancer.lb_name

}