variable "azure_region" {
  description = "Azure region to use."
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming."
  type        = string
}

variable "environment" {
  description = "Project environment."
  type        = string
}

variable "stack" {
  description = "Project stack name."
  type        = string
}

variable "azure_tenant_id" {
  description = "Azure tenant ID."
  type        = string
}
