locals {
  storage_account_repl_type = var.environment == "stg" || var.environment == "ithc" || var.environment == "prod" ? "ZRS" : "LRS"
}