locals {

  managed_identity_subscription_id = {
    ithc = {
      subscription = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
    }
    perftest = {
      subscription = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
    }
    aat = {
      subscription = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
    }
    prod = {
      subscription = "8999dec3-0104-4a27-94ee-6588559729d1"
    }
  }

}

provider "azurerm" {
  subscription_id            = local.managed_identity_subscription_id["${var.env}"].subscription
  skip_provider_registration = "true"
  features {}
  alias = "managed_identity_infra_sub"
}

resource "azurerm_user_assigned_identity" "managed_identity" {

  provider            = azurerm.managed_identity_infra_sub
  resource_group_name = "managed-identities-${var.env}-rg"
  location            = var.location

  name = "${var.product}-${var.env}-mi"

  tags  = module.ctags.common_tags
}

resource "azurerm_key_vault_access_policy" "managed_identity_access_policy" {
  key_vault_id = module.azurekeyvault.key_vault_id

  object_id    = azurerm_user_assigned_identity.managed_identity.principal_id
  tenant_id    = data.azurerm_client_config.current.tenant_id

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
