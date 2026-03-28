define bundle {

  input "state_import" {
    type        = list(object)
    default     = []
    description = "Import existing infrastructure using Terraform import blocks."

    attribute "to" {
      type = string
      description = "The instance address to import the resource into. It must match the address of an existing `resource` block."
    }
    attribute "id" {
      type = string
      description = "The cloud provider's ID for the resource to import."
    }
  }

  input "state_moved" {
    type        = list(object)
    default     = []
    description = "Move resources in Terraform state from one address to another."

    attribute "from" {
      type = string
      description = "The resources's previous address."
    }
    attribute "to" {
      type = string
      description = "The new address to relocate the resource to."
    }
  }
}
