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
