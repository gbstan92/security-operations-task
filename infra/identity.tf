resource "azurerm_user_assigned_identity" "this" {
  location            = azurerm_resource_group.this.location
  name                = "container-app-identity"
  resource_group_name = azurerm_resource_group.this.name
}