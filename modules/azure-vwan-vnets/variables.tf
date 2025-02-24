# -----------------------------
# Common Variables
# -----------------------------
variable "location" {
  description = "Azure region to use"
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location"
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
}

variable "environment" {
  description = "Project environment"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "extra_tags" {
  description = "Extra tags to add to all resources"
  type        = map(string)
  default     = {}
  nullable    = false
}

# -----------------------------
# Virtual Hub Variables
# -----------------------------
variable "virtual_hub_address_prefix" {
  description = "Virtual Hub address prefix"
  type        = string

  validation {
    condition     = can(cidrhost(var.virtual_hub_address_prefix, 0))
    error_message = "virtual_hub_address_prefix must be a valid CIDR block."
  }
}

variable "vnet_connections" {
  description = "Map of virtual networks to connect to the virtual hub"
  type = map(object({
    vnet_id                   = string
    internet_security_enabled = optional(bool, false)
  }))
}
