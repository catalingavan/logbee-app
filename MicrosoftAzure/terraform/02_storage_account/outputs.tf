output "storage_account_primary_access_key" {
  value     = azurerm_storage_account.logbee_storage_account.primary_access_key
  sensitive = true
}

output "storage_account_name" {
  value = azurerm_storage_account.logbee_storage_account.name
}

output "configuration_share_name" {
  value = azurerm_storage_share.logbee_configuration_share.name
}
