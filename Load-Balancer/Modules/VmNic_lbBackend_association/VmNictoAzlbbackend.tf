resource "azurerm_network_interface_backend_address_pool_association" "testniclbbackend" {
  network_interface_id    = data.azurerm_network_interface.vmnic.id
  ip_configuration_name   = "testconfiguration1"
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.pool.id
}

#this block is used to connect Loadbalancer backend pool to VM nic

data "azurerm_lb_backend_address_pool" "pool" {
  name            = var.bap_name
  loadbalancer_id = data.azurerm_lb.lb.id
}

data "azurerm_lb" "lb" {
  name                = var.lb_name
  resource_group_name = var.rg_name
}

data "azurerm_network_interface" "vmnic" {
  name                = var.nic_name
  resource_group_name = var.rg_name
}