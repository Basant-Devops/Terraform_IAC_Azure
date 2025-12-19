resource "azurerm_lb" "azlb" {
  name                = "TestLoadBalancer"
  location            = var.location
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = data.azurerm_public_ip.azdatapip.id
  }
}

resource "azurerm_lb_backend_address_pool" "azbackend" {
  loadbalancer_id = azurerm_lb.azlb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "probe" {
  loadbalancer_id = azurerm_lb.azlb.id
  name            = "netflix-probe"
  port            = 80
}

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id            = azurerm_lb.azlb.id
  name                       = "HTTP"
  protocol                   = "Tcp"
  frontend_port              = 80
  backend_port               = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids   = [azurerm_lb_backend_address_pool.azbackend.id]
  probe_id                   = azurerm_lb_probe.probe.id
}

output "lb_name" {
  value = azurerm_lb.azlb.name
}


