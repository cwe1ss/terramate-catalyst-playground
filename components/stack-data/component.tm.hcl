define "component" "metadata" {
  class   = "components/stack-data"
  version = "1.0.0"
  name    = "stack-data"
}

define "component" {
  input "stacks" {
    type = map(object)

    attribute "backend" {
      type = string
    }

    attribute "config" {
      type = any
    }
  }
}
