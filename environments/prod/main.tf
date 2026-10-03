module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "key_vault" {
  source = "../../modules/azurerm_key_vault"

  key_vaults = var.key_vaults

  key_vault_principal_id = var.key_vault_principal_id

  vm_admin_usernames = var.vm_admin_usernames
  vm_admin_passwords = var.vm_admin_passwords

  postgres_admin_usernames = var.postgres_admin_usernames
  postgres_admin_passwords = var.postgres_admin_passwords

  depends_on = [
    module.resource_group
  ]
}

module "virtual_network" {
  source = "../../modules/azurerm_virtual_network"
  vnets  = var.vnets

  depends_on = [module.resource_group]

}

module "subnet" {
  source  = "../../modules/azurerm_subnet"
  subnets = var.subnets



  depends_on = [module.virtual_network]

}

module "public_ip" {
  source = "../../modules/azurerm_public_ip"
  pips   = var.pips

  depends_on = [module.resource_group]

}

module "bastion_host" {
  source = "../../modules/azurerm_bastion_host"
  bsn    = var.bsn

  depends_on = [module.subnet, module.public_ip]

}

module "postgresql_flexible_server" {
  source = "../../modules/azurerm_postgresql_flexible_server"
  psql   = local.psql_with_credentials

  depends_on = [module.subnet]

}



module "linux_virtual_machine" {
  source = "../../modules/azurerm_linux_virtual_machine"
  vms    = local.vms_with_credentials

  depends_on = [module.subnet,
  module.public_ip]

}

