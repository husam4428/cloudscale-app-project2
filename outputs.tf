output "resource_group_name" {
  value = "husam-abdelmoez-proj2-aci-rg"
}

output "vm_public_ip" {
  value = azurerm_public_ip.publicip.ip_address
}
