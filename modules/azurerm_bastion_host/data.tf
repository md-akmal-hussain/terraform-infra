data "azurerm_subnet" "data" {
  for_each = var.bsn

  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet_name

}

data "azurerm_public_ip" "data_pip" {
  for_each = var.bsn

  name                = each.value.ipconfig_name
  resource_group_name = each.value.resource_group_name
}