terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  
  # السطرين هادم يمنعوا تيرامورم من فحص الصلاحيات المسبقة للاشتراك والخدمات
  skip_provider_registration = true
}
