module "service_principals" {
  count = var.ecs_entra_sp_enabled ? 1 : 0

  source  = "claranet/service-principal/azurerm"
  version = "~> 8.5.0"

  display_name = coalesce(var.custom_sp_name, join("-", compact(["sp-email", local.name_prefix, var.stack, var.client_name, var.location_short, var.environment, local.name_suffix])))
  owners       = var.ecs_entra_sp_owners

  token_display_name      = var.ecs_entra_sp_token_display_name
  token_validity_duration = var.ecs_entra_sp_token_validity_duration
  token_validity_end_date = var.ecs_entra_sp_token_validity_end_date

  scope_assignment = [{
    scope     = data.azurerm_subscription.main.id
    role_name = "ACS Email Write"
  }]
}
