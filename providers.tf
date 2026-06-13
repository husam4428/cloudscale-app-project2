terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.75.0" # هنا جبرناه يجيب إصدار حديث يدعم الميزة دي غصباً عنه
    }
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}
