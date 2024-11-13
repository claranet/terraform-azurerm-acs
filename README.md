# Azure Communication Services
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/acs/azurerm/)

Azure module to deploy a [Azure Communication Services](https://docs.microsoft.com/en-us/azure/xxxxxxx).

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
| >= 8.x.x       | **Unverified**    | 1.8.x            | >= 4.0          |
| >= 7.x.x       | 1.3.x             |                  | >= 3.0          |
| >= 6.x.x       | 1.x               |                  | >= 3.0          |
| >= 5.x.x       | 0.15.x            |                  | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   |                  | >= 2.0          |
| >= 3.x.x       | 0.12.x            |                  | >= 2.0          |
| >= 2.x.x       | 0.12.x            |                  | < 2.0           |
| <  2.x.x       | 0.11.x            |                  | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
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
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2.28 |
| azurerm | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | ~> 8.0.0 |
| service\_principals | claranet/service-principal/azurerm | ~> 8.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_communication_service.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/communication_service) | resource |
| [azurerm_communication_service_email_domain_association.azure_managed_domain](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/communication_service_email_domain_association) | resource |
| [azurerm_communication_service_email_domain_association.custom_domain](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/communication_service_email_domain_association) | resource |
| [azurerm_email_communication_service.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/email_communication_service) | resource |
| [azurerm_email_communication_service_domain.azure_managed_domain](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/email_communication_service_domain) | resource |
| [azurerm_email_communication_service_domain.custom_domain](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/email_communication_service_domain) | resource |
| [azurerm_resource_provider_registration.communication](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_provider_registration) | resource |
| [azurerm_role_definition.acs_email_write](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurecaf_name.acs](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.ecs](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurerm_subscription.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_tenant\_id | Azure tenant ID. | `string` | n/a | yes |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| custom\_ecs\_name | Custom Azure Email Communication Services name, generated if not set. | `string` | `""` | no |
| custom\_name | Custom Azure Communication Services name, generated if not set. | `string` | `""` | no |
| custom\_sp\_name | Custom Email Communication Services SP name, generated if not set. | `string` | `""` | no |
| data\_location | The location where the Communication service stores its data at rest. Possible values are `Africa`, `Asia Pacific`, `Australia`, `Brazil`, `Canada`, `Europe`, `France`, `Germany`, `India`, `Japan`, `Korea`, `Norway`, `Switzerland`, `UAE`, `UK` and `United States`. Defaults to `United States`. Changing this forces a new Communication Service to be created. | `string` | n/a | yes |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| diagnostic\_settings\_custom\_name | Custom name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| ecs\_azure\_managed\_domain\_enabled | Use Azure auto-generated managed domain. | `bool` | `false` | no |
| ecs\_custom\_domains | List of custom domains to be used for the Communication Service. Each object requires a `name` and `domain_management` field (Possible values are `CustomerManaged` or `CustomerManagedInExchangeOnline`). | <pre>list(object({<br/>    name                             = string<br/>    domain_management                = optional(string, "CustomerManaged")<br/>    user_engagement_tracking_enabled = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| ecs\_enabled | Enable Email Communication Service. | `bool` | `false` | no |
| ecs\_entra\_custom\_role\_enabled | Creates custom role to allow sending email from same subscription. | `bool` | `false` | no |
| ecs\_entra\_sp\_enabled | Creates Service Principal to send emails. | `bool` | `false` | no |
| ecs\_entra\_sp\_owners | Service Principal owners. | `list(string)` | `[]` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Additional tags to add on resources. | `map(string)` | `{}` | no |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br/>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br/>If you want to use Azure EventHub as a destination, you must provide a formatted string containing both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| resource\_group\_name | Name of the resource group. | `string` | n/a | yes |
| stack | Project stack name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ecs\_azure\_managed\_domain | Email Communication Services Azure managed domain. |
| ecs\_custom\_domains | Email Communication Services custom domains. |
| ecs\_id | Email Communication Services name. |
| ecs\_name | Email Communication Services name. |
| ecs\_smtp\_config | Email Communication Services SMTP configuration. Based on [documentation](https://learn.microsoft.com/en-us/azure/communication-services/quickstarts/email/send-email-smtp/smtp-authentication#creating-the-smtp-credentials-from-the-entra-application-information). |
| id | Azure Communication Services ID. |
| module\_service\_principal | Service principal module output. |
| name | Azure Communication Services name. |
| resource | Azure Communication Services output object. |
| resource\_ecs | Email Communication Services output object. |
<!-- END_TF_DOCS -->

## Related documentation

[Microsoft Azure documentation](https://learn.microsoft.com/en-us/azure/communication-services/overview)
[Connect a verified email domain](https://learn.microsoft.com/en-us/azure/communication-services/quickstarts/email/connect-email-communication-resource?pivots=azure-portal)
[Sending emails using SMTP](https://learn.microsoft.com/en-us/azure/communication-services/quickstarts/email/send-email-smtp/smtp-authentication)
