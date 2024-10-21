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

resource "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                = "logbee-cosmosdb"
  location            = data.terraform_remote_state.common.outputs.resource_group_location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  free_tier_enabled   = true

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = data.terraform_remote_state.common.outputs.resource_group_location
    failover_priority = 0
  }

  capacity {
    total_throughput_limit = 2000
  }
}

resource "azurerm_cosmosdb_sql_database" "frontend_sql_database" {
  name                = "logbee-frontend-sql-db"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb_account.name

  autoscale_settings {
    max_throughput = 1000
  }
}
