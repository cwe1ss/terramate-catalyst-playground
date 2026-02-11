define "component" "metadata" {
  class   = "components/resource-context"
  version = "1.0.0"
  name    = "resource-context"
}

define "component" {
  input "tenant" {
    type = string
  }
  input "stage" {
    type = string
  }
  input "names" {
    type = list(string)
  }
}

generate_hcl "main.tf" {
  content {
    tm_dynamic "module" {
      labels = ["this"]
      attributes = {
        for key, input in component.input : key => input.value
      }

      content {
        source = tm_source(".")
      }
    }
  }
}
