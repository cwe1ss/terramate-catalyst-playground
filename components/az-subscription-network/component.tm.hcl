define "component" "metadata" {
  class   = "components/az-subscription-network"
  version = "1.0.0"
  name    = "az-subscription-network"
}

define "component" {
  input "hcl_reference_subscription" {
    type = string
  }
  input "cidr_range" {
    type = string
  }
}

generate_hcl "main.tf" {
  content {
    tm_dynamic "module" {
      labels = ["network"]
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

    output "network" {
      value = module.network
    }
  }
}
