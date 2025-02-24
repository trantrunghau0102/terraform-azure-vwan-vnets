variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "location_short" {
  description = "Short string for Azure location"
  type        = string
  default     = "weu"
}

variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
  default     = "example"
}

variable "environment" {
  description = "Project environment"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "stack" {
  description = "Project stack name"
  type        = string
  default     = "network"
}

variable "tags" {
  description = "Default tags for resources"
  type        = map(string)
  default = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
  nullable = false
}

# Virtual WAN Variables
variable "virtual_hub_prefix" {
  description = "Virtual Hub address prefix"
  type        = string
  default     = "10.254.0.0/23"
  validation {
    condition     = can(cidrhost(var.virtual_hub_prefix, 0))
    error_message = "virtual_hub_prefix must be a valid CIDR block."
  }
}

variable "vnet_connections" {
  description = "Map of VNet connections to attach to Virtual WAN hub"
  type        = map(any)
  default     = {}
  nullable    = false
}
