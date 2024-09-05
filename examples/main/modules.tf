module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "run" {
  source  = "claranet/run/azurerm"
  version = "x.x.x"

  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name
}


module "acs" {
  source  = "claranet/acs/azurerm"
  version = "x.x.x"

  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

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
    },
    {
      name                             = "bar.fr"
      domain_management                = "CustomerManagedInExchangeOnline"
      user_engagement_tracking_enabled = true
    },
    {
      name = "baz.com"
    },
  ]

  extra_tags = {
    foo = "bar"
  }
}
