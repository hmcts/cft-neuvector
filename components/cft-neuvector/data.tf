data "azurerm_client_config" "current" {
}

data "azurerm_key_vault" "cftapps_key_vault" {
  name                = local.cftapps_keyvault["${var.env}"].name
  resource_group_name = local.cftapps_keyvault["${var.env}"].rg
}

data "azuread_group" "platops_sc" {
  display_name     = "DTS Platform Operations SC"
  security_enabled = true
}