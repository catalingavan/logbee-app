terraform {
  required_providers {
    azurerm = {
      version = "~> 4.5"
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id                 = local.subscription_id
  resource_provider_registrations = "none"
}

resource "azurerm_resource_group" "logbee" {
  name     = "logbee-resources"
  location = "West Europe"
}

resource "azurerm_container_registry" "acr" {
  name                = "logbee"
  resource_group_name = azurerm_resource_group.logbee.name
  location            = azurerm_resource_group.logbee.location
  sku                 = "Basic"
  admin_enabled       = false
}
