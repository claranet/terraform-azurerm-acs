resource "azurerm_role_definition" "acs_email_write" {
  count = var.ecs_entra_custom_role_enabled ? 1 : 0

  name        = "ACS Email Write"
  scope       = data.azurerm_subscription.main.id
  description = "Custom role to allow ACS Email Write."

  permissions {
    actions     = ["Microsoft.Communication/CommunicationServices/Read", "Microsoft.Communication/EmailServices/Write"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.main.id,
  ]
}
