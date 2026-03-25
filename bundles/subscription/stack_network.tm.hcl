define bundle stack "network" {
  condition = bundle.input.network.value != null && bundle.input.network.value != {}

  metadata {
    path = "/stacks/${bundle.input.tenant.value}/${bundle.input.project.value}-${bundle.environment.id}/network"

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
    source = "/components/stack-data"
    inputs = {
      stacks = {
        subscription = {
          config = {
            path = "../subscription/terraform.tfstate"
          }
        }
      }
    }
  }

  component "network" {
    source = "/components/terraform-module"

    inputs = {
      module_source = "/modules/az-subscription-network"
      module_name   = "network"

      hcl_variables = {
        context      = "module.this.context"
        subscription = "data.terraform_remote_state.subscription.outputs.subscription"
      }

      variables = {
        cidr_range = bundle.input.network.value.cidr_range
      }
    }
  }
}
