provider "azurerm" {
  version = "~> 2.5"
  features {}
}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = var.prefix

  tags = {
    environment = "Wireguard"
  }
}
