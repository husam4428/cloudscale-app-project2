data "azurerm_resource_group" "rg" {
  name = "husam-abdelmoez-proj2-aci-rg"
}

resource "azurerm_container_group" "aci" {
  name                = "husam-abdelmoez-aci"
  
  # 👇 يقرأ المنطقة المفتوحة والمربوطة بالمجلد تلقائياً
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  
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
