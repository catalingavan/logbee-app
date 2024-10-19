terraform {
  required_providers {
    azurerm = {
      version = "~> 4.5"
      source  = "hashicorp/azurerm"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 1.15"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id                 = local.subscription_id
  resource_provider_registrations = "none"
}

provider "azapi" {}

data "terraform_remote_state" "common" {
  backend = "local"
  config = {
    path = "../01_common/terraform.tfstate"
  }
}

data "terraform_remote_state" "storage_account" {
  backend = "local"
  config = {
    path = "../02_storage_account/terraform.tfstate"
  }
}

resource "azurerm_service_plan" "service_plan" {
  name                = "logbee-service-plan"
  location            = data.terraform_remote_state.common.outputs.resource_group_location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "logbee_frontend" {
  name                = "logbee-frontend-2"
  location            = data.terraform_remote_state.common.outputs.resource_group_location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group_name
  service_plan_id     = azurerm_service_plan.service_plan.id

  site_config {
    always_on = true
    application_stack {
      docker_image_name   = "catalingavan/logbee.frontend:1.2.1.2"
      docker_registry_url = "https://index.docker.io"
    }
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "true"
  }
}

resource "azurerm_linux_web_app" "logbee_frontend_3" {
  name                = "logbee-frontend-3"
  location            = data.terraform_remote_state.common.outputs.resource_group_location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group_name
  service_plan_id     = azurerm_service_plan.service_plan.id

  site_config {
    always_on = false
  }

  app_settings = {
    LOGBEE_CONFIGURATION_FILE_PATH = "/configuration/logbee.json"
  }

  storage_account {
    access_key   = data.terraform_remote_state.storage_account.outputs.primary_access_key
    account_name = data.terraform_remote_state.storage_account.outputs.name
    share_name   = data.terraform_remote_state.storage_account.configuration_share_name
    type         = "AzureFiles"

    # this name must match the value specified in docker-compose.yaml
    # - volumes {name}:/app/configuration
    name = "configuration"

    # we "inject" the files available in the AzureShare under /configuration/* directory inside logbee-frontend
    mount_path = "/configuration"
  }
}

# https://github.com/hashicorp/terraform-provider-azurerm/issues/16290#issuecomment-1618899156
# this is a workaround as azurerm_linux_web_app does not yet support creating a docker-compose 
resource "azapi_update_resource" "update_logbee_frontend_3" {
  resource_id = azurerm_linux_web_app.logbee_frontend_3.id
  type        = "Microsoft.Web/sites@2024-04-01"
  body = jsonencode({
    properties = {
      siteConfig = {
        linuxFxVersion = "COMPOSE|${base64encode(file("../../docker-compose.yaml"))}"
      }
    }
  })
}
