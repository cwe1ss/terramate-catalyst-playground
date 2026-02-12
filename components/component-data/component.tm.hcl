define "component" "metadata" {
  class   = "components/component-data"
  version = "1.0.0"
  name    = "component-data"
}

define "component" {
  input "components" {
    type = map(any)

    # attribute "backend" {
    #   type = string
    # }
    # attribute "config" {
    #   type = any
    # }
  }
}
