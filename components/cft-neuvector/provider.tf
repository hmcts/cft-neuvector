terraform {
  required_version = "~> 1.17.2"
  backend "azurerm" {
    subscription_id = "04d27a32-7a07-48b3-95b8-3c8691e1a263"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.72.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.10.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}

provider "azurerm" {
  alias                      = "managed_identity_infra_sub"
  subscription_id            = local.managed_identity_subscription_id["${var.env}"].subscription
  skip_provider_registration = "true"
  features {}
}
