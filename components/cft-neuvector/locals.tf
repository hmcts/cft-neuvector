locals {
  storage_account_repl_type = var.env == "stg" || var.env == "ithc" || var.env == "prod" ? "ZRS" : "LRS"

  managed_identity_subscription_id = {
    sbox = {
      subscription = "bf308a5c-0624-4334-8ff8-8dca9fd43783"
    }
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
  cftapps_keyvault = {
    sbox = {
      name = "cftapps-sbox"
      rg   = "core-infra-sbox-rg"
    }
    ithc = {
      name = "cftapps-ithc"
      rg   = "core-infra-ithc-rg"
    }
    perftest = {
      name = "cftapps-test"
      rg   = "core-infra-test-rg"
    }
    aat = {
      name = "cftapps-stg"
      rg   = "core-infra-stg-rg"
    }
    prod = {
      name = "cft-apps-prod"
      rg   = "core-infra-prod-rg"
    }
  }
}