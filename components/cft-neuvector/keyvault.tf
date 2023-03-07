module "azurekeyvault" {
  source                     = "git::https://github.com/hmcts/cnp-module-key-vault?ref=master"
  name                       = "cft${var.product}-${var.env}"
  product                    = var.product
  env                        = var.env
  resource_group_name        = azurerm_resource_group.rg.name
  product_group_name         = "DTS Platform Operations"
  common_tags                = module.ctags.common_tags
  object_id                  = data.azurerm_client_config.current.object_id
  managed_identity_object_id = data.azurerm_user_assigned_identity.managed_identity.principal_id
}

resource "azurerm_key_vault_access_policy" "sc_access_policy" {

  count = var.env == "prod" ? 1 : 0

  key_vault_id = module.azurekeyvault.key_vault_id

  object_id = data.azuread_group.platops_sc.object_id
  tenant_id = data.azurerm_client_config.current.tenant_id

  certificate_permissions = [
    "Get",
    "List",
    "Update",
    "Create",
    "Import",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "ManageContacts",
    "ManageIssuers",
    "GetIssuers",
    "ListIssuers",
    "SetIssuers",
    "DeleteIssuers",
  ]

  key_permissions = [
    "Create",
    "List",
    "Get",
    "Delete",
    "Update",
    "Import",
    "Backup",
    "Restore",
    "Recover",
  ]

  secret_permissions = [
    "Set",
    "List",
    "Get",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
  ]

  depends_on = [
    module.azurekeyvault
  ]
}