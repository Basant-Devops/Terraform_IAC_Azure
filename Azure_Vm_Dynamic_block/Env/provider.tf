terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.51.0"
    }
  }
  backend "azurerm" {
    resource_group_name   = "rg-secure"
    storage_account_name  = "backendaccount"
    container_name        = "backendcontainer"
    key                   = "newgen.tfstate"
    
  }
}

provider "azurerm" {
  features {}
  subscription_id = "4384363b-269f-4e6b-bb52-58030d963c7f"
}