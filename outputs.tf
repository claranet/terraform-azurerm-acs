output "acs" {
  description = "Azure Communication Services output object"
  value       = azurerm_communication_service.acs
}

output "id" {
  description = "Azure Communication Services ID"
  value       = azurerm_communication_service.acs.id
}

output "name" {
  description = "Azure Communication Services name"
  value       = azurerm_communication_service.acs.name
}

output "identity_principal_id" {
  description = "Azure Communication Services system identity principal ID"
  value       = try(azurerm_communication_service.acs.identity[0].principal_id, null)
}
