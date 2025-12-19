module "azrg" {
    source = "../root/rg"
    resource_group = var.resource_group
}

module "aznetwork" {
  depends_on = [ module.azrg ]
  source = "../root/vnet"
  virtual_network = var.virtual_network
 }

module "azsubnet" {
  depends_on = [ module.aznetwork, module.azrg ]
  source = "../root/subnet"
  demosubnet = var.demosubnet
}

module "azpip" {
  depends_on = [ module.azrg ]
  source = "../root/PIP"
  azpip = var.azpip
}
# will work only for 1 nic, if multiple nics then use below code
  
   #module "aznic" { 
  #depends_on = [ module.azsubnet, module.azpip ] 
  #source = "../root/Nic" 
  #network_interfaces = { for nic_key, nic_val in var.network_interfaces : nic_key => merge(
  #nic_val, { public_ip_id = module.azpip.azpip_id["subnet1"] 
  #subnet_id = module.azsubnet.subnet_ids["pip1"]
  # } ) } }


 module "aznic" {
  depends_on = [module.azsubnet, module.azpip]
  source     = "../root/Nic"

  network_interfaces = {
    for nic_key, nic_val in var.network_interfaces : nic_key => merge(
      nic_val,
      {
        # 1 ya multiple NICs ke liye safe
        #lookup(map, key, default)
        #“module.azsubnet.subnet_ids map me se nic_key wali value do; agar wo key nahi mili, to map ki pehli value de do.”
        public_ip_id = lookup(module.azpip.azpip_id, nic_key, values(module.azpip.azpip_id)[0])
        subnet_id    = lookup(module.azsubnet.subnet_ids, nic_key, values(module.azsubnet.subnet_ids)[0])
      }
    )
  }
}


module "azvm" {
  depends_on = [module.aznic]
  
  source     = "../root/vm"
  genvm      =  {
    for vm_key, vm_val in var.genvm : vm_key => merge(
      vm_val,
      {
        nic_ids = [lookup(module.aznic.nic_ids, vm_key, values(module.aznic.nic_ids)[0])]
      }
    )
  }
}