rgs = {
  rg1 = {
    name     = "rg-axion-systems-dev-01"
    location = "Central India"
  }
}

vnets = {
  vnet1 = {
    vnet_name           = "vnet-axion-systems-dev-01"
    resource_group_name = "rg-axion-systems-dev-01"
    location            = "Central India"
    address_space       = ["10.0.0.0/16"]

  }
}

subnets = {
  subnet1 = {
    subnet_name         = "frontend-subnet-axion-01"
    resource_group_name = "rg-axion-systems-dev-01"
    vnet_name           = "vnet-axion-systems-dev-01"
    address_prefixes    = ["10.0.1.0/24"]

  }
  subnet2 = {
    subnet_name         = "backend-subnet-axion-01"
    resource_group_name = "rg-axion-systems-dev-01"
    vnet_name           = "vnet-axion-systems-dev-01"
    address_prefixes    = ["10.0.2.0/24"]

  }

  subnet3 = {
    subnet_name         = "postgresql-subnet-axion-01"
    resource_group_name = "rg-axion-systems-dev-01"
    vnet_name           = "vnet-axion-systems-dev-01"
    address_prefixes    = ["10.0.3.0/24"]

  }

  subnet4 = {
    subnet_name         = "AzureBastionSubnet"
    resource_group_name = "rg-axion-systems-dev-01"
    vnet_name           = "vnet-axion-systems-dev-01"
    address_prefixes    = ["10.0.4.0/24"]

  }
}

pips = {

  pip1 = {
    pip_name            = "backend-pip-axion-01"
    resource_group_name = "rg-axion-systems-dev-01"
    location            = "Central India"
    allocation_method   = "Static"

  }

  pip2 = {
    pip_name            = "bsn-pip-axion-01"
    resource_group_name = "rg-axion-systems-dev-01"
    location            = "Central India"
    allocation_method   = "Static"

  }
}

bsn = {
  bsn1 = {
    bsn_name            = "bsn-axion-systems-dev-01"
    resource_group_name = "rg-axion-systems-dev-01"
    location            = "Central India"
    subnet_name         = "AzureBastionSubnet"
    vnet_name           = "vnet-axion-systems-dev-01"


    ipconfig_name = "bsn-pip-axion-01"
  }
}


psql = {
  psql1 = {
    psql_name           = "psqlflexibleserver-axion-01"
    resource_group_name = "rg-axion-systems-dev-01"
    location            = "Central India"
    version             = "12"

    storage_mb   = 32768
    storage_tier = "P4"
    sku_name     = "B_Standard_B1ms"

    public_network_access_enabled = true
  }
}

key_vaults = {
  keyvault1 = {
    key_vault_name              = "kv-axion-systems-dev-01"
    location                    = "Central India"
    resource_group_name         = "rg-axion-systems-dev-01"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 90
    purge_protection_enabled    = true
    key_vault_sku_name          = "standard"
  }
}


vms = {
  vm1 = {
    vm_name             = "frontend-vm-axion-01"
    resource_group_name = "rg-axion-systems-dev-01"
    location            = "central india"
    vm_size             = "Standard_D2as_v6"

    vcpus_per_core  = 1
    vcpus_available = 1

    disable_password_authentication = false

    vnet_name   = "vnet-axion-systems-dev-01"
    subnet_name = "frontend-subnet-axion-01"
    nic_name    = "nic-frontend-axion-01"
    pip_name    = null
    nsg_name    = "nsg-frontend-axion-01"

    sr_name                       = "SSH_HTTP_Rule"
    sr_priority                   = 100
    sr_direction                  = "Inbound"
    sr_access                     = "Allow"
    sr_protocol                   = "Tcp"
    sr_source_port_range          = "*"
    sr_destination_port_ranges    = ["22", "80"]
    sr_source_address_prefix      = "*"
    sr_destination_address_prefix = "*"

    ip_config_name                = "ipconfig1"
    private_ip_address_allocation = "Dynamic"

    os_caching              = "ReadWrite"
    os_storage_account_type = "Standard_LRS"

    sir_publisher = "Canonical"
    sir_offer     = "0001-com-ubuntu-server-jammy"
    sir_sku       = "22_04-lts-gen2"
    sir_version   = "latest"

  }

  vm2 = {
    vm_name             = "backend-vm-axion-01"
    resource_group_name = "rg-axion-systems-dev-01"
    location            = "central india"
    vm_size             = "Standard_D2as_v6"

    vcpus_per_core  = 1
    vcpus_available = 1

    disable_password_authentication = false

    vnet_name   = "vnet-axion-systems-dev-01"
    subnet_name = "backend-subnet-axion-01"
    nic_name    = "nic-backend-axion-01"
    pip_name    = "backend-pip-axion-01"
    nsg_name    = "nsg-backend-axion-01"

    sr_name                       = "SSH_HTTP_Rule"
    sr_priority                   = 100
    sr_direction                  = "Inbound"
    sr_access                     = "Allow"
    sr_protocol                   = "Tcp"
    sr_source_port_range          = "*"
    sr_destination_port_ranges    = ["22", "80", "8000"]
    sr_source_address_prefix      = "*"
    sr_destination_address_prefix = "*"

    ip_config_name                = "ipconfig1"
    private_ip_address_allocation = "Dynamic"

    os_caching              = "ReadWrite"
    os_storage_account_type = "Standard_LRS"

    sir_publisher = "Canonical"
    sir_offer     = "0001-com-ubuntu-server-jammy"
    sir_sku       = "22_04-lts-gen2"
    sir_version   = "latest"

  }
}
