define bundle stack "network" {
  condition = bundle.input.network_cidr_range.value != null && bundle.input.network_cidr_range.value != ""

  metadata {
    path = "/stacks/${bundle.input.tenant.value}/${bundle.input.project.value}-${bundle.environment.id}/network"

    name        = "Network"
    description = <<-EOF
      Subscription
    EOF

    tags = [
      bundle.class,
      "${bundle.class}/network",

      "project/${bundle.input.project.value}",
      "environment/${bundle.environment.id}",
    ]

    after = [
      "tag:${bundle.class}/subscription",
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

  component "data" {
    source = "/components/component-data"
    inputs = {
      components = {
        subscription = {
          backend = "local"
          config = {
            path = "../subscription/terraform.tfstate"
          }
        }
      }
    }
  }

  component "network" {
    source = "/components/az-subscription-network"

    inputs = {
      hcl_reference_subscription = "data.terraform_remote_state.subscription.outputs.subscription"

      cidr_range = bundle.input.network_cidr_range.value
    }
  }
}
