variable "context" {
  type = object({
    tenant = optional(string, "")
    stage  = optional(string, "")
    names  = optional(list(string), [])
  })
  nullable    = false
  description = "The resource context"
}

variable "network" {
  type = object({
    subscription_id = string
    vnet_cidr_range = string
  })
  nullable    = false
  description = "Outputs from the `az-subscription-network` component."
}

variable "internet_allowed_fqdns" {
  type = set(string)
}
