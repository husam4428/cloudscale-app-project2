terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # أو النسخة اللي تخدم بيها
    }
  }
  # إذا كنت مداير remote backend (تخزين سحابي) سيبه زي ما هو، أهم شيء البلوك اللي تحت 👇
}

provider "azurerm" {
  features {}

  # 👇 السطور هادي تجبر التيرامورم يقرا الـ Secrets من الـ Workflow مباشرة وم يدورش الـ Azure CLI
  use_msi = false
}
