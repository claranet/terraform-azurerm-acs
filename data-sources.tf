data "azurerm_subscription" "main" {
}

moved {
  from = data.azurerm_subscription.primary
  to   = data.azurerm_subscription.main
}
