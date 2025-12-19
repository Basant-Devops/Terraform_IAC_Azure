module "namespace" {
  source = "../../storage"  # This is the path to the module
    storageAccounts = var.storageAccounts
}