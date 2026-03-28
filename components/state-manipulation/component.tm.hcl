define "component" {
  metadata {
    class   = "components/state-manipulation"
    version = "1.0.0"
    name    = "state-manipulation"
  }

  input "import" {
    type    = list(object)
    default = []

    attribute "to" {
      type        = string
      description = "The instance address to import the resource into. It must match the address of an existing `resource` block."
    }
    attribute "id" {
      type        = string
      description = "The cloud provider's ID for the resource to import."
    }
  }

  input "moved" {
    type    = list(object)
    default = []

    attribute "from" {
      type        = string
      description = "The resources's previous address."
    }
    attribute "to" {
      type        = string
      description = "The new address to relocate the resource to."
    }
  }
}
