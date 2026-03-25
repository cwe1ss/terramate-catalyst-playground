define bundle stack "firewall" {
  condition = (
    bundle.input.network.value != null
    && bundle.input.network.value != {}
    && tm_length(bundle.input.network.value.internet_allowed_fqdns) > 0
  )

  metadata {
    path = "/stacks/${bundle.input.tenant.value}/${bundle.input.project.value}-${bundle.environment.id}/firewall"

    tags = [
      bundle.class,
      "${bundle.class}/firewall",

      "project/${bundle.input.project.value}",
      "environment/${bundle.environment.id}",
    ]

    after = [
      "tag:${bundle.class}/subscription",
      "tag:${bundle.class}/network",
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
        network = {
          config = {
            path = "../network/terraform.tfstate"
          }
        }
      }
    }
  }

  component "firewall" {
    source = "/components/terraform-module"

    inputs = {
      module_source = "/modules/az-subscription-firewall"
      module_name   = "firewall"

      hcl_variables = {
        context = "module.this.context"
        network = "data.terraform_remote_state.network.outputs.network"
      }

      variables = {
        internet_allowed_fqdns = bundle.input.network.value.internet_allowed_fqdns
      }
    }
  }
}

