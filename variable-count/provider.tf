terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }
}

provider "azurerm" {
  features {}
    subscription_id = "1493aa44-b33d-41d2-80b4-bc5aedf98ea9"
}