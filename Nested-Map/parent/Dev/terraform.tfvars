storageAccounts = {
  "sa1" = {
    name                     = "storagelease1"
    resource_group_name      = "ground1"
    location                 = "West Europe"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }

  "sa2" = {
    name                     = "storagelease2"
    resource_group_name      = "bground2"
    location                 = "Central India"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }

  "sa3" = {
    name                     = "storagelease3"
    resource_group_name      = "ground3"
    location                 = "Central India"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}