output "key_vault_ids" {
  description = "The IDs of the Azure Key Vaults."

  value = {
    for key, vault in azurerm_key_vault.vault :
    key => vault.id
  }
}

output "key_vault_names" {
  description = "The names of the Azure Key Vaults."

  value = {
    for key, vault in azurerm_key_vault.vault :
    key => vault.name
  }
}