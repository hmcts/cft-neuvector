locals {
  storage_account_repl_type = var.env == "stg" || var.env == "ithc" || var.env == "prod" ? "ZRS" : "LRS"
}