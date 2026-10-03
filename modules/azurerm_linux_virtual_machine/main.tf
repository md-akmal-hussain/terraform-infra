resource "azurerm_network_security_group" "nsg" {
  for_each = var.vms

  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name                       = each.value.sr_name
    priority                   = each.value.sr_priority
    direction                  = each.value.sr_direction
    access                     = each.value.sr_access
    protocol                   = each.value.sr_protocol
    source_port_range          = each.value.sr_source_port_range
    destination_port_ranges    = each.value.sr_destination_port_ranges
    source_address_prefix      = each.value.sr_source_address_prefix
    destination_address_prefix = each.value.sr_destination_address_prefix
  }
}

resource "azurerm_network_interface" "nic" {
  for_each = var.vms

  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name


  ip_configuration {
    name      = each.value.ip_config_name
    subnet_id = data.azurerm_subnet.data_subnet[each.key].id

    public_ip_address_id = try(
      data.azurerm_public_ip.data_pip[each.key].id, null
    )
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_assocciation" {
  for_each = var.vms

  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}


resource "azurerm_linux_virtual_machine" "vms" {
  for_each = var.vms

  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.vm_size




  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = each.value.disable_password_authentication


  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    caching              = each.value.os_caching
    storage_account_type = each.value.os_storage_account_type
  }

  source_image_reference {
    publisher = each.value.sir_publisher
    offer     = each.value.sir_offer
    sku       = each.value.sir_sku
    version   = each.value.sir_version
  }
}
