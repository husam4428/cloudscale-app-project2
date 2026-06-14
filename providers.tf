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

  # 👇 حط القيم الصريحة والارقام متاعك هنا مباشرة بين علامات التنصيص
  client_id       = "اكتب_هنا_الـ_Client_ID"
  client_secret   = "اكتب_هنا_الـ_Client_Secret"
  subscription_id = "اكتب_هنا_الـ_Subscription_ID"
  tenant_id       = "اكتب_هنا_الـ_Tenant_ID"
}
