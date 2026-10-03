resource "azurerm_postgresql_flexible_server" "psql" {

  for_each = var.psql

  name                = each.value.psql_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  version = each.value.version

  administrator_login    = each.value.administrator_login
  administrator_password = each.value.administrator_password

  storage_mb   = each.value.storage_mb
  storage_tier = each.value.storage_tier
  sku_name     = each.value.sku_name

  public_network_access_enabled = each.value.public_network_access_enabled

  lifecycle {
    ignore_changes = [
      zone
    ]
  }
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "backend_vm" {

  name             = "allow-backend-vm"
  server_id        = azurerm_postgresql_flexible_server.psql["psql1"].id
  start_ip_address = "20.219.60.63"
  end_ip_address   = "20.219.60.63"
}

resource "azurerm_postgresql_flexible_server_configuration" "azure_extensions" {

  name      = "azure.extensions"
  server_id = azurerm_postgresql_flexible_server.psql["psql1"].id
  value     = "timescaledb"
}

resource "azurerm_postgresql_flexible_server_configuration" "shared_preload_libraries" {
  name      = "shared_preload_libraries"
  server_id = azurerm_postgresql_flexible_server.psql["psql1"].id

  value = "pg_cron,pg_stat_statements,timescaledb"
}
