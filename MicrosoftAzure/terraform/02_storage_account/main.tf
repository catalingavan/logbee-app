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

data "terraform_remote_state" "common" {
  backend = "local"
  config = {
    path = "../01_common/terraform.tfstate"
  }
}

resource "azurerm_storage_account" "logbee_storage_account" {
  name                     = "logbeestorage"
  location                 = data.terraform_remote_state.common.outputs.resource_group_location
  resource_group_name      = data.terraform_remote_state.common.outputs.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "logbee_storage_container" {
  name                  = "logbee-frontend-container"
  storage_account_name  = azurerm_storage_account.logbee_storage_account.name
  container_access_type = "private"
}

resource "azurerm_storage_share" "logbee_configuration_share" {
  name                 = "logbee-configuration"
  storage_account_name = azurerm_storage_account.logbee_storage_account.name
  quota                = 1
}
