variable "context" {
  type = object({
    tenant = optional(string, "")
    stage  = optional(string, "")
    names  = optional(list(string), [])
  })
  nullable    = false
  description = "The resource context"
}

variable "budget_amount" {
  type        = number
  nullable    = false
  default     = 0
  description = "Budget in EUR per month"
}

variable "resource_providers" {
  type        = set(string)
  nullable    = false
  description = "A list of resource providers that should be registered for the subscription"
}
