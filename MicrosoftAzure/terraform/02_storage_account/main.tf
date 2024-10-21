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

# FileShare where we will upload the "logbee.json" configuration file consumed by the logbee-frontend AppService
resource "azurerm_storage_share" "logbee_frontend_share" {
  name                 = "logbee-frontend-share"
  storage_account_name = azurerm_storage_account.logbee_storage_account.name
  quota                = 1
}

# FileShare where we will upload the "logbee.json" configuration file consumed by the logbee-backend AppService
resource "azurerm_storage_share" "logbee_backend_share" {
  name                 = "logbee-backend-share"
  storage_account_name = azurerm_storage_account.logbee_storage_account.name
  quota                = 1
}
