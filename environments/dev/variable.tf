# ============================================================
# AXION SYSTEMS - TERRAFORM VARIABLES
# ============================================================


# ============================================================
# RESOURCE GROUP
# ============================================================

variable "rgs" {
  description = "Azure Resource Group configuration."

  type = map(object({
    name     = string
    location = string
  }))
}


# ============================================================
# VIRTUAL NETWORK
# ============================================================

variable "vnets" {
  description = "Azure Virtual Network configuration."

  type = map(object({
    vnet_name           = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
  }))
}


# ============================================================
# SUBNET
# ============================================================

variable "subnets" {
  description = "Azure Subnet configuration."

  type = map(object({
    subnet_name         = string
    resource_group_name = string
    vnet_name           = string
    address_prefixes    = list(string)
  }))
}


# ============================================================
# PUBLIC IP
# ============================================================

variable "pips" {
  description = "Azure Public IP configuration."

  type = map(object({
    pip_name            = string
    resource_group_name = string
    location            = string
    allocation_method   = string

  }))
}


# ============================================================
# LINUX VIRTUAL MACHINE
# ============================================================

variable "vms" {
  description = "Azure Linux Virtual Machine configuration."

  type = map(object({

    # VM configuration
    vm_name             = string
    resource_group_name = string
    location            = string
    vm_size             = string

    # Compute configuration
    vcpus_per_core  = number
    vcpus_available = number

    # Authentication
    disable_password_authentication = bool

    # Network configuration
    vnet_name   = string
    subnet_name = string
    nic_name    = string
    pip_name    = string
    nsg_name    = string

    # NSG security rule
    sr_name                       = string
    sr_priority                   = number
    sr_direction                  = string
    sr_access                     = string
    sr_protocol                   = string
    sr_source_port_range          = string
    sr_destination_port_ranges    = list(string)
    sr_source_address_prefix      = string
    sr_destination_address_prefix = string

    # NIC IP configuration
    ip_config_name                = string
    private_ip_address_allocation = string

    # OS disk
    os_caching              = string
    os_storage_account_type = string

    # Source image
    sir_publisher = string
    sir_offer     = string
    sir_sku       = string
    sir_version   = string
  }))
}


# ============================================================
# AZURE BASTION
# ============================================================

variable "bsn" {
  description = "Azure Bastion Host configuration."

  type = map(object({
    bsn_name            = string
    resource_group_name = string
    location            = string
    subnet_name         = string
    ipconfig_name       = string
    vnet_name           = string
  }))
}


# ============================================================
# POSTGRESQL FLEXIBLE SERVER
# ============================================================

variable "psql" {
  description = "Azure PostgreSQL Flexible Server configuration."

  type = map(object({
    psql_name                     = string
    resource_group_name           = string
    location                      = string
    version                       = string
    storage_mb                    = number
    storage_tier                  = string
    sku_name                      = string
    public_network_access_enabled = bool
  }))
}
variable "vm_admin_usernames" {
  description = "Admin usernames for Linux VMs."
  type        = map(string)
  sensitive   = true
}

variable "vm_admin_passwords" {
  description = "Admin passwords for Linux VMs."
  type        = map(string)
  sensitive   = true
}

variable "postgres_admin_usernames" {
  description = "Administrator usernames for PostgreSQL Flexible Servers."
  type        = map(string)
  sensitive   = true
}

variable "postgres_admin_passwords" {
  description = "Administrator passwords for PostgreSQL Flexible Servers."
  type        = map(string)
  sensitive   = true
}

variable "key_vaults" {
  description = "Azure Key Vault configuration."

  type = map(object({
    key_vault_name              = string
    location                    = string
    resource_group_name         = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
    key_vault_sku_name          = string
  }))
}

variable "key_vault_principal_id" {
  description = "Object ID of the Azure DevOps service connection identity."
  type        = string
}

