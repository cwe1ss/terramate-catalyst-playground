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
    tm_dynamic "module" {
      labels = ["iam"]
      attributes = {
        for key, input in component.input : key => input.value
        if !tm_startswith(key, "hcl_")
      }

      content {
        source       = tm_source(".")
        context      = module.this.context
        subscription = tm_hcl_expression(component.input.hcl_reference_subscription.value)
      }
    }

    output "iam" {
      value = module.iam
    }
  }
}
