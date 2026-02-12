define "component" "metadata" {
  class   = "components/az-subscription-iam"
  version = "1.0.0"
  name    = "az-subscription-iam"
}
define "component" {
  input "hcl_reference_subscription" {
    type = string
  }
  input "groups" {
    type = map(any)
  }
}

generate_hcl "main.tf" {
  content {
    module "iam" {
      source       = tm_source(".")
      context      = module.this.context
      subscription = tm_hcl_expression(component.input.hcl_reference_subscription.value)

      groups = component.input.groups.value
    }

    output "iam" {
      value = module.iam
    }
  }
}
