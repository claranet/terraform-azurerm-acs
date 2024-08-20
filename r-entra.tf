data "azurerm_subscription" "primary" {
}

resource "azurerm_role_definition" "acs_email_write" {
  count = var.ecs_entra_custom_role_enabled ? 1 : 0

  name        = "ACS Email Write"
  scope       = data.azurerm_subscription.primary.id
  description = "Custom role to allow ACS Email Write"

  permissions {
    actions     = ["Microsoft.Communication/CommunicationServices/Read", "Microsoft.Communication/EmailServices/Write"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id,
  ]
}

module "service_principals" {
  count = var.ecs_entra_sp_enabled ? 1 : 0

  source  = "claranet/service-principal/azurerm"
  version = "~> 7.4.0"

  sp_display_name = coalesce(var.custom_sp_name, join("-", compact(["sp-email", local.name_prefix, var.stack, var.client_name, var.location_short, var.environment, local.name_suffix])))
  sp_owners       = var.ecs_entra_sp_owners

  sp_scope_assignment = [{
    scope     = data.azurerm_subscription.primary.id
    role_name = "ACS Email Write"
  }]
}
