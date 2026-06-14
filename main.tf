# 1. قراءة المجلد الممنوح لك من الجامعة تلقائياً لتفادي إيرور الصلاحيات والـ Region
data "azurerm_resource_group" "rg" {
  name = "husam-abdelmoez-proj2-aci-rg"
}

# 2. إنشاء الشبكة الافتراضية في نفس موقع المجلد
resource "azurerm_virtual_network" "vnet" {
  name                = "cloudscale-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

# 3. إنشاء الـ Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "cloudscale-subnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 4. إنشاء الـ Public IP لتتمكن من فتح الموقع في المتصفح
resource "azurerm_public_ip" "publicip" {
  name                = "cloudscale-ip"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

# 5. إعدادات الحماية وفتح المنافذ (SSH 22 و HTTP 80)
resource "azurerm_network_security_group" "nsg" {
  name                = "cloudscale-nsg"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# 6. كرت الشبكة وربطه بالـ Subnet والـ IP العام
resource "azurerm_network_interface" "nic" {
  name                = "cloudscale-nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

# 7. ربط الحماية بكرت الشبكة
resource "azurerm_network_interface_security_group_association" "assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# 8. توليد مفتاح SSH ديناميكي داخل التيرامورم مباشرة لتفادي خطأ الملف المفقود
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4000
}

# 9. بناء السيرفر وتشغيل السكربت لتثبيت دكر وتشغيل حاويتك تلقائياً
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "cloudscale-vm"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = "Standard_B1s" # الحجم الاقتصادي القياسي لاشتراكات الطلاب
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  # 👇 قراءة السكربت مباشرة لتشغيل الحاوية فور نهوض السيرفر
  custom_data = base64encode(file("cloud-init.sh"))
}
