resource "azurerm_container_registry" "this" {
  name                = "cfsecops"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_role_assignment" "this" {
  scope                = azurerm_container_registry.this.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}


