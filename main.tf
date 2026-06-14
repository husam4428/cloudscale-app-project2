resource "azurerm_container_group" "aci" {
  name                = "husam-abdelmoez-aci"
  
  # 👇 استخدام ريجن الطلاب القياسي لتخطي سياسة الحظر
  location            = "centralus"
  
  resource_group_name = "husam-abdelmoez-proj2-aci-rg"
  os_type             = "Linux"
  sku                 = "Standard"
  ip_address_type     = "Public"
  dns_name_label      = "cloudscale-husam-app"

  container {
    name   = "webserver"
    image  = "husam4428/cloudscale-app:v1"
    cpu    = "1.0"
    memory = "1.0"

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
