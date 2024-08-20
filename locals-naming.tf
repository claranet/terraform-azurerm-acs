locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  acs_name = coalesce(var.custom_acs_name, data.azurecaf_name.acs.result)
  ecs_name = coalesce(var.custom_ecs_name, data.azurecaf_name.ecs.result)
}
