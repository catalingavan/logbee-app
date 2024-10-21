output "storage_account_primary_access_key" {
  value     = azurerm_storage_account.logbee_storage_account.primary_access_key
  sensitive = true
}

output "storage_account_name" {
  value = azurerm_storage_account.logbee_storage_account.name
}

output "logbee_frontend_share_name" {
  value = azurerm_storage_share.logbee_frontend_share.name
}

output "logbee_frontend_share_id" {
  value = azurerm_storage_share.logbee_frontend_share.id
}

output "logbee_backend_share_name" {
  value = azurerm_storage_share.logbee_backend_share.name
}

output "logbee_backend_share_id" {
  value = azurerm_storage_share.logbee_backend_share.id
}
