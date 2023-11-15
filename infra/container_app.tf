resource "azurerm_log_analytics_workspace" "this" {
  name                = "cf-secops"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "this" {
  name                       = "cf-secops"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}

resource "azurerm_container_app" "this" {
  name                         = "cf-secops"
  container_app_environment_id = azurerm_container_app_environment.this.id
  resource_group_name          = azurerm_resource_group.this.name
  revision_mode                = "Single"

  template {
    container {
      name   = "cf-secops"
      image  = "cfsecops.azurecr.io/cf-secops:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }

    container {
      name  = "postgres"
      image = "cfsecops.azurecr.io/postgres:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
  
  identity {
    type = "UserAssigned"
    identity_ids = [
        azurerm_user_assigned_identity.this.id
    ]
  }

  registry {
    server = "cfsecops.azurecr.io"
    identity = azurerm_user_assigned_identity.this.id
  }

  depends_on = [
    azurerm_role_assignment.this
  ]
}