locals {
  # Common values
  location       = var.location
  location_short = var.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  # Resource naming 
  name_prefix = lower("${local.client_name}-${local.environment}-${local.stack}")

  # Default tags
  default_tags = merge(
    var.tags,
    {
      Environment = local.environment
      Stack       = local.stack
      Client      = local.client_name
    }
  )
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = format("%s-rg", local.name_prefix)
  location = local.location
  tags     = local.default_tags
}

# Virtual WAN
module "virtual_wan" {
  source = "../../modules/azure-vwan-vnets"

  # Base Configuration
  location            = local.location
  location_short      = local.location_short
  client_name         = local.client_name
  environment         = local.environment
  stack               = local.stack
  resource_group_name = azurerm_resource_group.rg.name

  virtual_hub_address_prefix = var.virtual_hub_prefix

  # VNET Connections
  vnet_connections = var.vnet_connections
}
