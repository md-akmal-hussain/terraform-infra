variable "pips" {
  description = "Azure Public IP configuration."

  type = map(object({
    pip_name            = string
    resource_group_name = string
    location            = string
    allocation_method   = string

  }))
}