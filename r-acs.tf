resource "azurerm_communication_service" "acs" {
  name = local.acs_name

  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(local.default_tags, var.extra_tags)
}
