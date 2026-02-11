define "component" "metadata" {
  class   = "components/az-subscription-iam"
  version = "1.0.0"
  name    = "az-subscription-iam"
}
define "component" {
  input "groups" {
    type = map(object({
      users = list(string)
    }))
  }
}

generate_hcl "main.tf" {
  content {
    tm_dynamic "module" {
      labels = ["iam"]
      attributes = {
        for key, input in component.input : key => input.value
      }

      content {
        source       = tm_source(".")
        context      = module.this.context
        subscription = module.subscription
      }
    }

    output "iam" {
      value = module.iam
    }
  }
}
