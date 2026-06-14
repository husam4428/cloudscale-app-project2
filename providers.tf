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

  # 👇 الفلاق البديل والمضمون لتخطي حظر صلاحيات الجامعة في الإصدارات القديمة
  skip_provider_registration = true
}
