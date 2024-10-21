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

data "terraform_remote_state" "storage_account" {
  backend = "local"
  config = {
    path = "../02_storage_account/terraform.tfstate"
  }
}

resource "azurerm_storage_share_file" "logbee_frontend_config" {
  name             = "logbee.json"
  content_type     = "application/json"
  storage_share_id = data.terraform_remote_state.storage_account.outputs.logbee_frontend_share_id
  source           = "../../logbee-frontend.json"
}
