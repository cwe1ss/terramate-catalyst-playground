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
    module "subscription" {
      source  = tm_source(".")
      context = module.this.context

      budget_amount      = component.input.budget_amount.value
      resource_providers = component.input.resource_providers.value
    }

    output "subscription" {
      value = module.subscription
    }
  }
}
