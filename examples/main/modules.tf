module "acs" {
  source  = "claranet/acs/azurerm"
  version = "x.x.x"

  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name
  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack

  azure_tenant_id = var.azure_tenant_id

  logs_destinations_ids = [
    module.run.logs_storage_account_id,
    module.run.log_analytics_workspace_id
  ]

  data_location                    = module.azure_region.data_location
  ecs_entra_custom_role_enabled    = true
  ecs_entra_sp_enabled             = true
  ecs_enabled                      = true
  ecs_azure_managed_domain_enabled = true
  ecs_custom_domains = [
    {
      name                             = "foo.com"
      domain_management                = "CustomerManaged"
      user_engagement_tracking_enabled = false
      association_enabled              = false
    },
    {
      name                             = "bar.fr"
      domain_management                = "CustomerManagedInExchangeOnline"
      user_engagement_tracking_enabled = true
      association_enabled              = true
    },
    {
      name = "baz.com"
    },
  ]

  extra_tags = {
    foo = "bar"
  }
}
