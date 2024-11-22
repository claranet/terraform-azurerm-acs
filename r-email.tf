resource "azurerm_email_communication_service" "main" {
  count = var.ecs_enabled ? 1 : 0

  name                = local.ecs_name
  resource_group_name = var.resource_group_name
  data_location       = var.data_location

  tags = merge(local.default_tags, var.extra_tags)
}

moved {
  from = azurerm_email_communication_service.ecs
  to   = azurerm_email_communication_service.main
}

resource "azurerm_email_communication_service_domain" "azure_managed_domain" {
  count = var.ecs_azure_managed_domain_enabled && var.ecs_enabled ? 1 : 0

  name              = "AzureManagedDomain"
  email_service_id  = azurerm_email_communication_service.main[0].id
  domain_management = "AzureManaged"

  tags = merge(local.default_tags, var.extra_tags)
}

resource "azurerm_email_communication_service_domain" "custom_domain" {
  for_each = {
    for custom_domain in var.ecs_custom_domains : custom_domain.name => custom_domain if var.ecs_enabled
  }

  name              = each.value.name
  email_service_id  = azurerm_email_communication_service.main[0].id
  domain_management = each.value.domain_management

  tags = merge(local.default_tags, var.extra_tags)
}

resource "azurerm_communication_service_email_domain_association" "azure_managed_domain" {
  count = var.ecs_azure_managed_domain_enabled && var.ecs_enabled ? 1 : 0

  communication_service_id = azurerm_communication_service.main.id
  email_service_domain_id  = azurerm_email_communication_service_domain.azure_managed_domain[0].id
}

resource "azurerm_communication_service_email_domain_association" "custom_domain" {
  for_each = {
    for custom_domain in var.ecs_custom_domains : custom_domain.name => custom_domain if var.ecs_enabled
  }

  communication_service_id = azurerm_communication_service.main.id
  email_service_domain_id  = azurerm_email_communication_service_domain.custom_domain[each.key].id
}
