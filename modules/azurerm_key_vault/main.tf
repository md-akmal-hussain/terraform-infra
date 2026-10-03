resource "azurerm_key_vault" "vault" {
  for_each = var.key_vaults

  name                        = each.value.key_vault_name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption

  tenant_id = data.azurerm_client_config.current.tenant_id

  soft_delete_retention_days = each.value.soft_delete_retention_days
  purge_protection_enabled   = each.value.purge_protection_enabled
  sku_name                   = each.value.key_vault_sku_name

  rbac_authorization_enabled = true
}

resource "azurerm_role_assignment" "key_vault_secrets_user" {
  for_each = var.key_vaults

  scope                = azurerm_key_vault.vault[each.key].id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = var.key_vault_principal_id
}

resource "azurerm_key_vault_secret" "vm_username" {
  for_each = toset(nonsensitive(keys(var.vm_admin_usernames)))

  name         = "${each.key}-username"
  value        = var.vm_admin_usernames[each.key]
  key_vault_id = azurerm_key_vault.vault["keyvault1"].id

  depends_on = [
    azurerm_role_assignment.key_vault_secrets_user
  ]
}

resource "azurerm_key_vault_secret" "vm_password" {
  for_each = toset(nonsensitive(keys(var.vm_admin_passwords)))

  name         = "${each.key}-password"
  value        = var.vm_admin_passwords[each.key]
  key_vault_id = azurerm_key_vault.vault["keyvault1"].id

  depends_on = [
    azurerm_role_assignment.key_vault_secrets_user
  ]
}

resource "azurerm_key_vault_secret" "postgres_username" {
  for_each = toset(nonsensitive(keys(var.postgres_admin_usernames)))

  name         = "${each.key}-username"
  value        = var.postgres_admin_usernames[each.key]
  key_vault_id = azurerm_key_vault.vault["keyvault1"].id

  depends_on = [
    azurerm_role_assignment.key_vault_secrets_user
  ]
}

resource "azurerm_key_vault_secret" "postgres_password" {
  for_each = toset(nonsensitive(keys(var.postgres_admin_passwords)))

  name         = "${each.key}-password"
  value        = var.postgres_admin_passwords[each.key]
  key_vault_id = azurerm_key_vault.vault["keyvault1"].id

  depends_on = [
    azurerm_role_assignment.key_vault_secrets_user
  ]
}
