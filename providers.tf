terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}

  # 👇 هذا السطر السحري الذي يتخطى نقص صلاحيات حساب الجامعة ويمنع الـ 403
  resource_provider_registrations = "none"
}
