variable "subscription" {
  type = object({
    subscription_id = string
  })
  nullable    = false
  description = "Outputs from the `az-subscription` component."
}

variable "cidr_range" {
  type = string
}
