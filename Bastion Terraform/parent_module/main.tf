module "group" {
  source   = "../child_module/resource"
  name     = "rg-demo"
  location = "North Europe"
}

module "vnet" {
  source              = "../child_module/vnet"
  vnetname            = "vnet-demo"
  address_space       = ["10.0.0.0/16"]
  location            = module.group.rg_location
  resource_group_name = module.group.rg_name
}

module "vm" {
  source              = "../child_module/vm"
  name                = "demo-vm"
  location            = module.group.rg_location
  resource_group_name = module.group.rg_name
  subnet_id           = module.vnet.vm_subnet_id
  admin_username      = "azureuser"
  admin_password      = "P@ssword1234!"
}

module "bastion" {
  source              = "../child_module/bastion"
  name                = "demo-bastion"
  location            = module.group.rg_location
  resource_group_name = module.group.rg_name
  subnet_id           = module.vnet.bastion_subnet_id
}

module "nat" {
  source              = "../child_module/nat"
  name                = "demo-nat"
  location            = module.group.rg_location
  rg_name             = module.group.rg_name
  subnet_id           = module.vnet.vnet_subnet_id
  depends_on          = [ module.vnet ]

}

