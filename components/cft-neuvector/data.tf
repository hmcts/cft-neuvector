data "azurerm_client_config" "current" {
}

data "azurerm_user_assigned_identity" "managed_identity" {
  name                = "${var.product}-${var.env}-mi"
  resource_group_name = "managed-identities-${var.env}-rg"
}

data "azuread_group" "platops_sc" {
  display_name     = "DTS Platform Operations SC"
  security_enabled = true
}