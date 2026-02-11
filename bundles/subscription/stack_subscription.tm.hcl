# A stack that combines two components

define bundle stack "subscription" {
  metadata {
    path = "/stacks/${bundle.input.tenant.value}/${bundle.input.project.value}-${bundle.input.stage.value}/subscription"
    name = "Subscription"

    tags = [
      bundle.class,
      "${bundle.class}/subscription",

      "project/${bundle.input.project.value}",
      "stage/${bundle.input.stage.value}",
    ]
  }

  component "context" {
    source = "/components/resource-context"
    inputs = {
      tenant = bundle.input.tenant.value
      stage  = bundle.input.stage.value
      names  = [bundle.input.project.value]
    }
  }

  component "subscription" {
    source = "/components/az-subscription"

    inputs = {
      budget_amount = tm_coalesce(
        tm_try(bundle.input.budget_amount.value, null),
        tm_try(global.component_defaults.subscription.budget_amount, null),
        0,
      )

      resource_providers = tm_concat(
        bundle.input.resource_providers.value,
        tm_try(global.component_defaults.subscription.resource_providers, []),
      )
    }
  }

  component "iam" {
    source = "/components/az-subscription-iam"

    inputs {
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
