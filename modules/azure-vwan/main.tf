locals {
  name_prefix = lower("${var.client_name}-${var.environment}-${var.stack}")

  default_tags = merge(
    {
      environment = var.environment
      stack       = var.stack
      managed_by  = "terraform"
      client      = var.client_name
    },
    var.extra_tags
  )
}

# -----------------------------
# Virtual WAN Configuration
# -----------------------------
resource "azurerm_virtual_wan" "vwan" {
  name                = format("%s-vwan", local.name_prefix)
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = local.default_tags

  lifecycle {
    prevent_destroy = true
  }
}

# -----------------------------
# Virtual Hub Configuration
# -----------------------------
resource "azurerm_virtual_hub" "hub" {
  depends_on          = [azurerm_virtual_wan.vwan]
  name                = format("%s-hub", local.name_prefix)
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_wan_id      = azurerm_virtual_wan.vwan.id
  address_prefix      = var.virtual_hub_address_prefix

  tags = local.default_tags

  lifecycle {
    prevent_destroy = true
  }
}

# -----------------------------
# Virtual Hub VNET Connections
# -----------------------------
# Process input VNet connections to normalize both simple and complex inputs
locals {
  normalized_connections = {
    for name, value in var.vnet_connections : name => {
      vnet_id                   = try(value.vnet_id, value)
      internet_security_enabled = try(value.internet_security_enabled, false)
    }
  }
}

resource "azurerm_virtual_hub_connection" "vnet_connections" {
  for_each = local.normalized_connections

  name                      = each.key
  virtual_hub_id            = azurerm_virtual_hub.hub.id
  remote_virtual_network_id = each.value.vnet_id
  internet_security_enabled = each.value.internet_security_enabled

  depends_on = [
    azurerm_virtual_hub.hub
  ]
}
