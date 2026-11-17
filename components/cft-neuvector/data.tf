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

data "azurerm_user_assigned_identity" "cftapps_uami" {
  name                = "DCD-CFTAPPS-${local.env}-WIF-mi"
  resource_group_name = "azure-devops-service-connections-${local.env}-rg"
}
