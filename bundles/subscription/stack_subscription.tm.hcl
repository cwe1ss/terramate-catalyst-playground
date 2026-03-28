# A stack that combines two components

define bundle stack "subscription" {
  metadata {
    path = "/stacks/${bundle.input.tenant.value}/${bundle.input.project.value}-${bundle.environment.id}/subscription"

    tags = [
      bundle.class,
      "${bundle.class}/subscription",

      "project/${bundle.input.project.value}",
      "environment/${bundle.environment.id}",
    ]
  }

  component "context" {
    source = "/components/resource-context"
    inputs = {
      tenant = bundle.input.tenant.value
      stage  = bundle.environment.id
      names  = [bundle.input.project.value]
    }
  }

  component "subscription" {
    source = "/components/terraform-module"

    inputs = {
      module_source = "/modules/az-subscription"
      module_name   = "subscription"

      hcl_variables = {
        context = "module.this.context"
      }

      variables = {
        budget_amount = (bundle.input.budget_amount.value > 0
          ? bundle.input.budget_amount.value
          : tm_try(global.component_defaults.subscription.budget_amount, 100)
        )

        resource_providers = tm_concat(
          bundle.input.resource_providers.value,
          tm_try(global.component_defaults.subscription.resource_providers, []),
        )
      }
    }
  }

  component "iam" {
    source = "/components/terraform-module"

    inputs {
      module_source = "/modules/az-subscription-iam"
      module_name   = "iam"

      hcl_variables = {
        context      = "module.this.context"
        subscription = "module.subscription"
      }

      variables = {
        groups = {
          admin = {
            users = bundle.input.iam_admin_users.value
            role  = "admin"
          }
          readonly = {
            users = bundle.input.iam_readonly_users.value
            role  = "readonly"
          }
        }
      }
    }
  }

  component "state" {
    source = "/components/state-manipulation"

    inputs {
      import = bundle.input.state_import.value
      moved  = bundle.input.state_moved.value
    }
  }
}
