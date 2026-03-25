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
