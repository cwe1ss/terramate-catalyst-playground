define "component" {
  metadata {
    class   = "components/resource-context"
    version = "1.0.0"
    name    = "resource-context"
  }

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
