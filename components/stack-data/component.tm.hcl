define "component" {
  metadata {
    class   = "components/stack-data"
    version = "1.0.0"
    name    = "stack-data"
  }

  input "stacks" {
    type = map(object)

    attribute "backend" {
      type        = string
      default     = ""
      description = "The type of backend to use. Defaults to `global.terraform.backend.type` if not set."
    }

    attribute "config" {
      type = any
    }

    attribute "defer_first_read" {
      type        = bool
      default     = true
      description = <<-EOT
        If this is set to `true`, an additional `terraform_data`-resource will be generated
        and set as the `depends_on` for the data lookup.
        This will ensure that the data will *not* be read on the very first `terraform plan`.
      EOT
    }
  }
}
