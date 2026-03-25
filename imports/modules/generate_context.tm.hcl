generate_hcl "_context.tf" {
  content {
    variable "context" {
      type = object({
        tenant = optional(string, "")
        stage  = optional(string, "")
        names  = optional(list(string), [])
      })
      nullable    = false
      description = "The resource context"
    }
  }
}
