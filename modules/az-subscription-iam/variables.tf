variable "subscription" {
  type = object({
    subscription_id = string
  })
  nullable    = false
  description = "Outputs from the `subscription` component."
}

variable "groups" {
  type = map(object({
    users = list(string)
    role  = string
  }))
}
