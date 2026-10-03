locals {

  vms_with_credentials = {
    for vm_key, vm in var.vms : vm_key => merge(
      vm,
      {
        admin_username = var.vm_admin_usernames[vm_key]
        admin_password = var.vm_admin_passwords[vm_key]
      }
    )
  }

  psql_with_credentials = {
    for psql_key, server in var.psql : psql_key => merge(
      server,
      {
        administrator_login    = var.postgres_admin_usernames[psql_key]
        administrator_password = var.postgres_admin_passwords[psql_key]
      }
    )
  }

}