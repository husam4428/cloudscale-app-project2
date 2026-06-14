resource "azurerm_container_group" "aci" {
  name                = "husam-abdelmoez-aci2"
  location            = "swedencentral"
  resource_group_name = "husam-abdelmoez-proj2-aci-rg" # الاسم المطابق لصورك بالظبط 🎯
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
    Project     = "Project2"
    Environment = "production"
    StudentName = "Husam and Abdelmoez"
  }
}
