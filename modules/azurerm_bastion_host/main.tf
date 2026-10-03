resource "azurerm_bastion_host" "bsn" {
  for_each = var.bsn

  name                = each.value.bsn_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = each.value.ipconfig_name
    subnet_id            = data.azurerm_subnet.data[each.key].id
    public_ip_address_id = data.azurerm_public_ip.data_pip[each.key].id
  }
}