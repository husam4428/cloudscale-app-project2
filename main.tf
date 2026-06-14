# 1. قراءة بيانات المجلد الممنوح لك والموجود في السويد تلقائياً
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# 2. إنشاء مجموعة الحاويات (ACI) داخل منطقة Sweden Central المسموحة
resource "azurerm_container_group" "aci" {
  name                = var.container_group_name
  location            = "swedencentral" # 🇸🇪 المنطقة المضمونة والمطابقة لصورتك
  resource_group_name = data.azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku                 = "Standard"
  ip_address_type     = "Public"
  dns_name_label      = "cloudscale-husam-app"

  container {
    name   = "webserver"
    image  = var.image_name
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  # الالتزام التام بالـ Tags المطلوبة بالاسم في مستند المشروع (صفحة 2)
  tags = {
    Project     = "Project2"
    Environment = "production"
    StudentName = "Husam and Abdelmoez"
  }
}
