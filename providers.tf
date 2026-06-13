terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  # حذفنا السطر المسبب للإيرور، واستبدلناه بقفل الميزات التي تسبب لك الـ 403
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
