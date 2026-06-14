# 1️⃣ خطوة بناء الـ Resource Group تلقائياً لكي يملك التيرامورم صلاحياتها
resource "azurerm_resource_group" "rg" {
  name     = "husam-abdelmoez-proj2-aci-rg"
  location = "swedencentral"
}

# 2️⃣ بناء الحاوية وربطها بالـ Resource Group أعلاه
resource "azurerm_container_group" "aci" {
  name                = "husam-abdelmoez-aci"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
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
