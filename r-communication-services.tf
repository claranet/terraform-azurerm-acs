resource "azurerm_resource_provider_registration" "communication" {
  name = "Microsoft.Communication"
}

resource "azurerm_communication_service" "acs" {
  name                = local.acs_name
  resource_group_name = var.resource_group_name
  data_location       = var.data_location

  tags = merge(local.default_tags, var.extra_tags)
}
