resource "azurerm_resource_group" "this" {
  name     = "cf-secops"
  location = "UK South"
}

resource "azurerm_container_registry" "this" {
  name                = "cfsecops"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Basic"
  admin_enabled       = false
}