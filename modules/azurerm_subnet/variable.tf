variable "subnets" {
  description = "Azure Subnet configuration."

  type = map(object({
    subnet_name         = string
    resource_group_name = string
    vnet_name           = string
    address_prefixes    = list(string)
  }))
}