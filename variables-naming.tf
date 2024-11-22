# Generic naming variables
variable "name_prefix" {
  description = "Optional prefix for the generated name."
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name."
  type        = string
  default     = ""
}

# Custom naming override
variable "custom_name" {
  description = "Custom Azure Communication Services name, generated if not set."
  type        = string
  default     = ""
}

variable "custom_ecs_name" {
  description = "Custom Azure Email Communication Services name, generated if not set."
  type        = string
  default     = ""
}

variable "custom_sp_name" {
  description = "Custom Email Communication Services SP name, generated if not set."
  type        = string
  default     = ""
}
