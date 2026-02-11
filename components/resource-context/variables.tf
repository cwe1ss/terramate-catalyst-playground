variable "context" {
  type = object({
    tenant = optional(string, "")
    stage  = optional(string, "")
    names  = optional(list(string), [])
  })
  nullable = false
  default  = {}
}

variable "tenant" {
  type     = string
  nullable = false
  default  = ""
}

variable "stage" {
  type     = string
  nullable = false
  default  = ""
}

variable "names" {
  type     = list(string)
  nullable = false
  default  = []
}

variable "resource_prefix" {
  type     = string
  nullable = false
  default  = ""
}
