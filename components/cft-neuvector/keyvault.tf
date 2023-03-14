module "azurekeyvault" {
  source                  = "git::https://github.com/hmcts/cnp-module-key-vault?ref=dxw/security_enabled"
  name                    = "cft${var.product}-${var.env}"
  product                 = var.product
  env                     = var.env
  resource_group_name     = azurerm_resource_group.rg.name
  product_group_name      = "DTS Platform Operations"
  common_tags             = module.ctags.common_tags
  create_managed_identity = true
  object_id               = data.azurerm_client_config.current.object_id
}
