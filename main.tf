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
  resource_provider_registrations = "none"
}

resource "azurerm_container_group" "aci" {
  name                = "husam-abdelmoez-aci"
  location            = "Switzerland North"
  resource_group_name = "husam-abdelmoez-proj2-aci-rg"
  os_type             = "Linux"
  sku                 = "Standard"
  ip_address_type     = "Public"
  dns_name_label      = "cloudscale-husam-app"

  container {
    name   = "webserver"
    image  = "husam4428/cloudscale-app:v1"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    Environment = "production"
    Project     = "Project2"
    StudentName = "Husam and Abdelmoez"
  }
}

output "resource_group_name" {
  value = "husam-abdelmoez-proj2-aci-rg"
}

output "aci_public_ip" {
  value = azurerm_container_group.aci.ip_address
}

output "aci_fqdn" {
  value = azurerm_container_group.aci.fqdn
}
