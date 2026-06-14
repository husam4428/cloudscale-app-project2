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

  # إيقاف الـ MSI والـ CLI وإجبار التيرامورم على قراءة الـ Secrets مباشرة
  use_msi = false
}
