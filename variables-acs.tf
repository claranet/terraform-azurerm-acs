variable "data_location" {
  description = "The location where the Communication service stores its data at rest. Possible values are `Africa`, `Asia Pacific`, `Australia`, `Brazil`, `Canada`, `Europe`, `France`, `Germany`, `India`, `Japan`, `Korea`, `Norway`, `Switzerland`, `UAE`, `UK` and `United States`. Defaults to `United States`. Changing this forces a new Communication Service to be created."
  type        = string
}

variable "ecs_enabled" {
  description = "Enable Email Communication Service."
  type        = bool
  default     = false
}

variable "ecs_azure_managed_domain_enabled" {
  description = "Use Azure auto-generated managed domain."
  type        = bool
  default     = false
}

variable "ecs_custom_domains" {
  description = "List of custom domains to be used for the Communication Service. Each object requires a `name` and `domain_management` field (Possible values are `CustomerManaged` or `CustomerManagedInExchangeOnline`)."
  type = list(object({
    name                             = string
    domain_management                = optional(string, "CustomerManaged")
    user_engagement_tracking_enabled = optional(bool, false)
    association_enabled              = optional(bool, false)
  }))
  default = []
}

variable "ecs_entra_custom_role_enabled" {
  description = "Creates custom role to allow sending email from same subscription."
  type        = bool
  default     = false
}

variable "ecs_entra_sp_enabled" {
  description = "Creates Service Principal to send emails."
  type        = bool
  default     = false
}

variable "ecs_entra_sp_owners" {
  description = "Service Principal owners."
  type        = list(string)
  default     = []
}

variable "ecs_entra_sp_token_display_name" {
  description = "A display name for the Service Principal's password."
  type        = string
  default     = "Terraform managed secret"
}

variable "ecs_entra_sp_token_validity_duration" {
  description = "Service Principal token/password duration before it expires. Defaults to 2 years. See [documentation](https://pkg.go.dev/time#ParseDuration)."
  type        = string
  default     = "${24 * 365 * 2}h" # 2 years
}

variable "ecs_entra_sp_token_validity_end_date" {
  description = "Service Principal token/password end date. This property cannot be used alongside `var.ecs_entra_sp_token_validity_duration`."
  type        = string
  default     = null
}
