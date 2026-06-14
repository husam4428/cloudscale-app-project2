# 1. قراءة المجلد الممنوح لك من الجامعة
data "azurerm_resource_group" "rg" {
  name = "husam-abdelmoez-proj2-aci-rg"
}

# 2. إنشاء الشبكة الافتراضية في الريجن المفتوح للطلاب
resource "azurerm_virtual_network" "vnet" {
  name                = "cloudscale-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "centralus" # 👇 ريجن الطلاب القياسي والمضمون
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
  location            = "centralus" # 👇 توجيه للريجن المفتوح
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

# 5. إعدادات الحماية وفتح المنافذ (SSH 22 و HTTP 80)
resource "azurerm_network_security_group" "nsg" {
  name                = "cloudscale-nsg"
  location            = "centralus" # 👇 توجيه للريجن المفتوح
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
  location            = "centralus" # 👇 توجيه للريجن المفتوح
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

# 8. توليد مفتاح SSH ديناميكي
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4000
}

# 9. بناء السيرفر وتشغيل السكربت لتثبيت دكر وتشغيل حاويتك تلقائياً
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "cloudscale-vm"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = "centralus" # 👇 توجيه السيرفر للريجن المفتوح للطلاب
  size                = "Standard_B1s" 
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

  custom_data = base64encode(<<-EOF
              #!/bin/bash
              apt update -y
              apt install docker.io -y
              systemctl enable docker
              systemctl start docker
              docker run -d --restart always -p 80:80 husam4428/cloudscale-app:v1
              EOF
  )
}
