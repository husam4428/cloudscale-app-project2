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

  # منع التيرامورم من محاولة تسجيل أي شيء خارج حدود مجموعتك
  skip_provider_registration = true
}
