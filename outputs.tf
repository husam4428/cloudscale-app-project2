output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "aci_public_ip" {
  value = azurerm_container_group.aci.ip_address
}

output "aci_fqdn" {
  value = azurerm_container_group.aci.fqdn
}