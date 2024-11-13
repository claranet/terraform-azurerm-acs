output "resource" {
  description = "Azure Communication Services output object."
  value       = azurerm_communication_service.main
}

output "id" {
  description = "Azure Communication Services ID."
  value       = azurerm_communication_service.main.id
}

output "name" {
  description = "Azure Communication Services name."
  value       = azurerm_communication_service.main.name
}

output "ecs" {
  description = "Email Communication Services output object."
  value       = azurerm_email_communication_service.main
}

output "ecs_id" {
  description = "Email Communication Services name."
  value       = one(azurerm_email_communication_service.main[*].id)
}

output "ecs_name" {
  description = "Email Communication Services name."
  value       = one(azurerm_email_communication_service.main[*].name)
}

output "ecs_azure_managed_domain" {
  description = "Email Communication Services Azure managed domain."
  value       = azurerm_email_communication_service_domain.azure_managed_domain
}

output "ecs_custom_domains" {
  description = "Email Communication Services custom domains."
  value       = azurerm_email_communication_service_domain.custom_domain
}

output "ecs_smtp_config" {
  description = "Email Communication Services SMTP configuration. Based on [documentation](https://learn.microsoft.com/en-us/azure/communication-services/quickstarts/email/send-email-smtp/smtp-authentication#creating-the-smtp-credentials-from-the-entra-application-information)."
  value = {
    host     = "smtp.azurecomm.net"
    port     = 587
    username = format("%s.%s.%s", azurerm_communication_service.main.name, one(module.service_principals[*].app_id), var.azure_tenant_id)
    password = one(module.service_principals[*].secret_key)
  }
  sensitive = true
}

output "service_principal" {
  description = "Azure Communication Services service principal."
  value       = module.service_principals
}
