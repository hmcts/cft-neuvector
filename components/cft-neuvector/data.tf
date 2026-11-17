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
  provider            = azurerm.managed_identity_infra_sub
  name                = var.env == "ptl" ? "DTS-${local.uami_env}-WIF-mi" : "DCD-CFTAPPS-${local.uami_env}-WIF-MI"
  resource_group_name = var.env == "prod" ? "managed-identities-${local.uami_env}-rg" : var.env == "ptl" ? "azure-devops-service-connections-${var.env}-rg" : "azure-devops-service-connections-${local.uami_env}-rg"
}
