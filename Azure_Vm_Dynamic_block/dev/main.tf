module "azvaults" {
    source = "../module/azurerm_KV"
    key_vaults = var.key_vaults
}