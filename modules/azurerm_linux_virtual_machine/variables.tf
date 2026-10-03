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
    admin_username                  = string
    admin_password                  = string

    # Network configuration
    vnet_name   = string
    subnet_name = string
    nic_name    = string
    pip_name    = string
    nsg_name    = string

    # NSG Rule
    sr_name                       = string
    sr_priority                   = number
    sr_direction                  = string
    sr_access                     = string
    sr_protocol                   = string
    sr_source_port_range          = string
    sr_destination_port_ranges    = list(string)
    sr_source_address_prefix      = string
    sr_destination_address_prefix = string

    # NIC IP Configuration
    ip_config_name                = string
    private_ip_address_allocation = string

    # OS Disk
    os_caching              = string
    os_storage_account_type = string

    # Source Image
    sir_publisher = string
    sir_offer     = string
    sir_sku       = string
    sir_version   = string
  }))


}