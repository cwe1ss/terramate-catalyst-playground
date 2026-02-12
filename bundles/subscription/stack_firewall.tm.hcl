define bundle stack "firewall" {
  condition = tm_length(bundle.input.firewall_internet_allowed_fqdns.value) > 0

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
    source = "/components/component-data"
    inputs = {
      components = {
        network = {
          backend = "local"
          config = {
            path = "../network/terraform.tfstate"
          }
        }
      }
    }
  }

  component "firewall" {
    source = "/components/az-subscription-firewall"

    inputs = {
      hcl_reference_network = "data.terraform_remote_state.network.outputs.network"

      internet_allowed_fqdns = bundle.input.firewall_internet_allowed_fqdns.value
    }
  }
}

