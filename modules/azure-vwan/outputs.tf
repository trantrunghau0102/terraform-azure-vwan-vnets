# -----------------------------
# Virtual WAN Outputs
# -----------------------------
output "virtual_wan_id" {
  description = "The ID of the Virtual WAN"
  value       = azurerm_virtual_wan.vwan.id
}

output "virtual_wan_name" {
  description = "The name of the Virtual WAN"
  value       = azurerm_virtual_wan.vwan.name
}

# -----------------------------
# Virtual Hub Outputs  
# -----------------------------
output "virtual_hub_id" {
  description = "The ID of the Virtual Hub"
  value       = azurerm_virtual_hub.hub.id
}

output "virtual_hub_name" {
  description = "The name of the Virtual Hub"
  value       = azurerm_virtual_hub.hub.name
}

output "virtual_hub_address_prefix" {
  description = "The address prefix of the Virtual Hub"
  value       = azurerm_virtual_hub.hub.address_prefix
}

# -----------------------------
# VNet Connection Outputs  
# -----------------------------
output "virtual_hub_connections" {
  description = "Map of Virtual Hub connections created"
  value = {
    for name, conn in azurerm_virtual_hub_connection.vnet_connections : name => {
      id                        = conn.id
      name                      = conn.name
      remote_virtual_network_id = conn.remote_virtual_network_id
      internet_security_enabled = conn.internet_security_enabled
    }
  }
}

output "virtual_hub_connection_ids" {
  description = "List of Virtual Hub Connection IDs"
  value       = [for conn in azurerm_virtual_hub_connection.vnet_connections : conn.id]
}

output "connected_vnets" {
  description = "List of VNet IDs connected to the Virtual WAN Hub"
  value       = [for conn in azurerm_virtual_hub_connection.vnet_connections : conn.remote_virtual_network_id]
}

output "resource_group_name" {
  description = "The name of the resource group where all resources are deployed"
  value       = var.resource_group_name
}

output "location" {
  description = "The location where all resources are deployed"
  value       = var.location
}
