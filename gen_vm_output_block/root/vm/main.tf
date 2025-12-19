data "azurerm_key_vault" "kv" {
  name                = "GenVm-KV"
  resource_group_name = "rg-secure"
}
# here e have a keyvault named "GenVm-KV" in resource group "GenVm-KV"
# we have secrets for vm as per vm name with suffix -password

data "azurerm_key_vault_secret" "vm_passwords" {
  for_each     = var.genvm
  name         = "${each.value.name}-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_linux_virtual_machine" "dev-vm" {
  for_each = var.genvm

  name                = "${each.value.name}-vm"
  location            = each.value.location
  resource_group_name = each.value.rg_name
  size                = each.value.vm_size
  admin_username      = each.value.admin_username
  admin_password      = data.azurerm_key_vault_secret.vm_passwords[each.key].value 
  disable_password_authentication = false
  network_interface_ids = each.value.nic_ids

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}