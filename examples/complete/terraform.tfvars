# Common configuration
location       = "eastus"
location_short = "eus"
client_name    = "company"
environment    = "dev"
stack          = "network"

# Virtual Hub configuration
virtual_hub_prefix = "10.100.0.0/23"

# Tags
tags = {
  Project    = "Cloud Migration"
  CostCenter = "IT-123456"
  Owner      = "NetworkTeam"
  ManagedBy  = "Terraform"
}

# VNet connections
vnet_connections = {
  "conn-prod-vnet" = {
    vnet_id                   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prod-rg/providers/Microsoft.Network/virtualNetworks/prod-vnet"
    internet_security_enabled = true
  },

  "conn-dev-vnet" = {
    vnet_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/dev-rg/providers/Microsoft.Network/virtualNetworks/dev-vnet"
  },

  "conn-01-dev-vnet"        = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/dev-rg/providers/Microsoft.Network/virtualNetworks/dev-vnet"
  "conn-02-test-vnet"       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet"
  "conn-03-prod-vnet"       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/prod-rg/providers/Microsoft.Network/virtualNetworks/prod-vnet"
  "conn-04-analytics-vnet"  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/analytics-rg/providers/Microsoft.Network/virtualNetworks/analytics-vnet"
  "conn-05-shared-services" = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/shared-rg/providers/Microsoft.Network/virtualNetworks/shared-vnet"
  "conn-06-billing-vnet"    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/billing-rg/providers/Microsoft.Network/virtualNetworks/billing-vnet"
  "conn-07-logging-vnet"    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/logging-rg/providers/Microsoft.Network/virtualNetworks/logging-vnet"
  "conn-08-data-vnet"       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/data-rg/providers/Microsoft.Network/virtualNetworks/data-vnet"
  "conn-09-backup-vnet"     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/backup-rg/providers/Microsoft.Network/virtualNetworks/backup-vnet"
  "conn-10-infra-vnet"      = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/infra-rg/providers/Microsoft.Network/virtualNetworks/infra-vnet"
}

