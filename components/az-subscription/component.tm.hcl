define "component" "metadata" {
  class   = "components/az-subscription"
  version = "1.0.0"
  name    = "az-subscription"
}

define "component" {
  input "budget_amount" {
    type        = number
    description = "Budget in EUR per month"
  }
  input "resource_providers" {
    type        = set(string)
    description = "A list of resource providers that should be registered for the subscription"
  }
}

generate_hcl "main.tf" {
  content {
    tm_dynamic "module" {
      labels = ["subscription"]
      attributes = {
        for key, input in component.input : key => input.value
      }

      content {
        source  = tm_source(".")
        context = module.this.context
      }
    }

    output "subscription" {
      value = module.subscription
    }
  }
}
