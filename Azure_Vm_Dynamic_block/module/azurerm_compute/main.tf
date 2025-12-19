
resource "azurerm_network_interface" "aznic" {
  for_each = var.vms
  name                = each.value.nicname
  location            = each.value.location
  resource_group_name = each.value.rg_name

  # Dynamic IP configurations
  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations != null ? each.value.ip_configurations : []
    content {
      name                          = ip_configuration.value.confname
      subnet_id                     = data.azurerm_subnet.datasubnet[each.key].id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      private_ip_address            = lookup(ip_configuration.value, "private_ip_address", null)
      primary                       = lookup(ip_configuration.value, "primary", false)
      public_ip_address_id          = data.azurerm_public_ip.datapip[each.key].id
      # it will look for data source of public IP with the same key as of the NIC
      # data.azurerm_public_ip.datapip[nics.key].id
    }
  }

  tags = lookup(each.value, "tags", {})
}



resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vms
  name                            = each.value.vmname
  resource_group_name             = each.value.rg_name
  location                        = each.value.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "P@sswqwerw341"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.aznic[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

source_image_reference {
    publisher = lookup(each.value.image, "publisher", "Canonical")
    offer     = lookup(each.value.image, "offer", "0001-com-ubuntu-server-jammy")
    sku       = lookup(each.value.image, "sku", "22_04-lts")
    version   = lookup(each.value.image, "version", "latest")
  }
}


