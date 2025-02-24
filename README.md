# Azure Virtual WAN Terraform Module

This module creates an Azure Virtual WAN and Virtual Hub, providing a central connectivity point for multiple VNets.

## Features

* Creates Azure Virtual WAN
* Creates a Virtual Hub in a specified region
* Supports connecting multiple VNets to the Virtual Hub
* Configurable internet security for VNet connections

## Usage

```hcl
module "virtual_wan" {
  source = "path/to/module/azure-vwan"

  # Required Parameters
  location            = "eastus"
  location_short      = "eus"
  client_name         = "company"
  environment         = "dev"
  stack               = "network"
  resource_group_name = "rg-network-hub"
  
  virtual_hub_address_prefix = "10.10.0.0/23"
  
  # VNet connections - supports both simple and detailed formats
  vnet_connections = {
    # Simple format - just VNet ID
    "conn-spoke1" = "/subscriptions/.../resourceGroups/spoke1-rg/providers/Microsoft.Network/virtualNetworks/spoke1-vnet"
    
    # Detailed format with additional parameters
    "conn-spoke2" = {
      vnet_id = "/subscriptions/.../resourceGroups/spoke2-rg/providers/Microsoft.Network/virtualNetworks/spoke2-vnet"
      internet_security_enabled = true
    }
  }
  
  # Optional Parameters
  extra_tags = {
    CostCenter = "IT-123456"
    Owner      = "NetworkTeam"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0, < 2.0.0 |
| azurerm | >= 3.0, < 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| location | Azure region to use | `string` | n/a | yes |
| location_short | Short string for Azure location | `string` | n/a | yes |
| client_name | Client name/account used in naming | `string` | n/a | yes |
| environment | Project environment (dev, staging, prod) | `string` | n/a | yes |
| stack | Project stack name | `string` | n/a | yes |
| resource_group_name | Resource group name | `string` | n/a | yes |
| virtual_hub_address_prefix | Virtual Hub address prefix (CIDR format) | `string` | n/a | yes |
| vnet_connections | Map of VNet connections to the Virtual Hub | `map(object)` | n/a | yes |
| extra_tags | Extra tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| virtual_wan_id | The ID of the Virtual WAN |
| virtual_wan_name | The name of the Virtual WAN |
| virtual_hub_id | The ID of the Virtual Hub |
| virtual_hub_name | The name of the Virtual Hub |
| virtual_hub_address_prefix | The address prefix of the Virtual Hub |
| virtual_hub_connections | Map of Virtual Hub connections created |
| virtual_hub_connection_ids | List of Virtual Hub Connection IDs |
| connected_vnets | List of VNet IDs connected to the Virtual WAN Hub |
| resource_group_name | The name of the resource group where all resources are deployed |
| location | The location where all resources are deployed |

## Notes

* The `prevent_destroy` lifecycle rule is set on the Virtual WAN and Virtual Hub to prevent accidental deletion
* VNet connections support simple string format or detailed object format with additional parameters