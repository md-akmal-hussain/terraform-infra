variable "rgs" {
  description = "Azure Resource Group configuration."

  type = map(object({
    name     = string
    location = string
  }))
}