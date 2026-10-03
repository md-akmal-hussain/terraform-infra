data "azurerm_subnet" "data_subnet" {
  for_each = var.vms

  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet_name
}

data "azurerm_public_ip" "data_pip" {

  for_each = {
    for key, value in var.vms : key => value
    if value.pip_name != null
  }

  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}