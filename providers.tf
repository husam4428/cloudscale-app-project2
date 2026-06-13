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
  
  # منع تيرامورم من تسجيل الخدمات أو فحص الصلاحيات المسبقة للاشتراك
  skip_provider_registration = true
}
