provider "azurerm" {
  subscription_id            = local.managed_identity_subscription_id["${var.env}"].subscription
  skip_provider_registration = "true"
  features {}
  alias = "managed_identity_infra_sub"
}

resource "azurerm_user_assigned_identity" "managed_identity" {
  provider            = azurerm.managed_identity_infra_sub
  name                = "${var.product}-${var.env}-mi"
  resource_group_name = "managed-identities-${var.env}-rg"
  location            = var.location
  tags                = module.ctags.common_tags
}

resource "azurerm_key_vault_access_policy" "managed_identity_access_policy" {
  key_vault_id = module.azurekeyvault.key_vault_id

  object_id = azurerm_user_assigned_identity.managed_identity.principal_id
  tenant_id = data.azurerm_client_config.current.tenant_id

  key_permissions = [
    "Get",
    "List",
  ]

  certificate_permissions = [
    "Get",
    "List",
  ]

  secret_permissions = [
    "Get",
    "List",
  ]
}

resource "azurerm_key_vault_access_policy" "cftapps_kv_access_policy" {
  key_vault_id = data.azurerm_key_vault.cftapps_key_vault.id

  object_id = azurerm_user_assigned_identity.managed_identity.principal_id
  tenant_id = data.azurerm_client_config.current.tenant_id

  key_permissions = [
    "Get",
    "List",
  ]

  certificate_permissions = [
    "Get",
    "List",
  ]

  secret_permissions = [
    "Get",
    "List",
  ]
}
