variable "psql" {
  description = "Azure PostgreSQL Flexible Server configuration."

  type = map(object({

    # PostgreSQL Server
    psql_name           = string
    resource_group_name = string
    location            = string
    version             = string

    # Authentication
    administrator_login    = string
    administrator_password = string

    # Storage
    storage_mb   = number
    storage_tier = string

    # SKU
    sku_name = string

    # Network
    public_network_access_enabled = bool
  }))
}

