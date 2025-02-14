module "service_principals" {
  count = var.ecs_entra_sp_enabled ? 1 : 0

  source  = "claranet/service-principal/azurerm"
  version = "~> 8.1.0"

  display_name = coalesce(var.custom_sp_name, join("-", compact(["sp-email", local.name_prefix, var.stack, var.client_name, var.location_short, var.environment, local.name_suffix])))
  owners       = var.ecs_entra_sp_owners

  scope_assignment = [{
    scope     = data.azurerm_subscription.main.id
    role_name = "ACS Email Write"
  }]
}
