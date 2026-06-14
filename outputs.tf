output "resource_group_name" {
  value = "husam-abdelmoez-proj2-aci-rg"
}

output "aci_private_ip" {
  value = azurerm_container_group.aci.ip_address
}
