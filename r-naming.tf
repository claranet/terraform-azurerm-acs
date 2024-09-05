data "azurecaf_name" "acs" {
  name          = var.stack
  resource_type = "azurerm_communication_service"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "ecs" {
  name          = var.stack
  resource_type = "azurerm_role_definition" #azurerm_email_communication_service NOT AVAILABLE YET

  prefixes    = compact(["ecs", local.name_prefix])
  suffixes    = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug    = false #var.use_caf_naming
  clean_input = true
  separator   = "-"
}
