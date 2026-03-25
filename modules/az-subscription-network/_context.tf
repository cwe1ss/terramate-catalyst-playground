# TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

variable "context" {
  description = "The resource context"
  nullable    = false
  type = object({
    tenant = optional(string, "")
    stage  = optional(string, "")
    names = optional(list(string), [
    ])
  })
}
