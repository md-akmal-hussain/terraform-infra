variable "bsn" {
  description = "Azure Bastion Host configuration."

  type = map(object({

    bsn_name            = string
    resource_group_name = string
    location            = string
    subnet_name         = string
    ipconfig_name       = string
    vnet_name           = string

  }))
}
