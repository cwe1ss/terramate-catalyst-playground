define "component" "metadata" {
  class   = "components/remote-state"
  version = "1.0.0"
  name    = "remote-state"
}

define "component" {
  input "module_name" {
    type = string
  }
  input "backend" {
    type = string
  }
  input "config" {
    type = any
  }
}

generate_hcl "main.tf" {
  content {
    tm_dynamic "module" {
      labels = [component.input.module_name.value]

      content {
        source  = tm_source(".")
        backend = component.input.backend.value
        config  = component.input.config.value
      }
    }
  }
}
