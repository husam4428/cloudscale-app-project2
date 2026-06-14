output "resource_group_name" {
  value = "husam-abdelmoez-proj2-aci-rg"
}

output "aci_public_ip" {
  value = azurerm_container_group.aci.ip_address
}

output "aci_fqdn" {
  value = azurerm_container_group.aci.fqdn
}
