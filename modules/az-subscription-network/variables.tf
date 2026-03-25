variable "context" {
  type = object({
    tenant = optional(string, "")
    stage  = optional(string, "")
    names  = optional(list(string), [])
  })
  nullable    = false
  description = "The resource context"
}

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
