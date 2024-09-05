resource "azurerm_email_communication_service" "ecs" {
  count = var.ecs_enabled ? 1 : 0

  name                = local.ecs_name
  resource_group_name = var.resource_group_name
  data_location       = var.data_location

  tags = merge(local.default_tags, var.extra_tags)
}

resource "azurerm_email_communication_service_domain" "azure_managed_domain" {
  count = var.ecs_azure_managed_domain_enabled && var.ecs_enabled ? 1 : 0

  name              = "AzureManagedDomain"
  email_service_id  = azurerm_email_communication_service.ecs[0].id
  domain_management = "AzureManaged"

  tags = merge(local.default_tags, var.extra_tags)
}

resource "azurerm_email_communication_service_domain" "custom_domain" {
  for_each = {
    for custom_domain in var.ecs_custom_domains : custom_domain.name => custom_domain if var.ecs_enabled
  }

  name              = each.value.name
  email_service_id  = azurerm_email_communication_service.ecs[0].id
  domain_management = each.value.domain_management

  tags = merge(local.default_tags, var.extra_tags)
}
