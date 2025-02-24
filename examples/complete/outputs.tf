# Resource Group Outputs
output "resource_group_name" {
  description = "Resource group name"
  value       = azurerm_resource_group.rg.name
}

# Virtual WAN Hub Outputs
output "virtual_wan_id" {
  description = "The ID of the Virtual WAN"
  value       = module.virtual_wan.virtual_wan_id
}

output "virtual_hub_id" {
  description = "The ID of the Virtual Hub"
  value       = module.virtual_wan.virtual_hub_id
}

# VNet Connection Outputs
output "virtual_hub_connections" {
  description = "Map of Virtual Hub connections"
  value       = module.virtual_wan.virtual_hub_connections
}

output "connected_vnets" {
  description = "List of VNet IDs connected to the Virtual WAN Hub"
  value       = [for conn in module.virtual_wan.virtual_hub_connections : conn.remote_virtual_network_id]
}

output "connection_status" {
  description = "Map of connection names to their internet security status"
  value = {
    for name, conn in module.virtual_wan.virtual_hub_connections :
    name => {
      vnet_id                   = conn.remote_virtual_network_id
      internet_security_enabled = conn.internet_security_enabled
    }
  }
}
