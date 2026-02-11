define bundle stack "firewall" {
  condition = tm_length(bundle.input.firewall_internet_allowed_fqdns.value) > 0

  metadata {
    path = "/stacks/${bundle.input.tenant.value}/${bundle.input.project.value}-${bundle.input.stage.value}/firewall"
    name = "Firewall"

    tags = [
      bundle.class,
      "${bundle.class}/firewall",

      "project/${bundle.input.project.value}",
      "stage/${bundle.input.stage.value}",
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
      stage  = bundle.input.stage.value
      names  = [bundle.input.project.value]
    }
  }

  component "network" {
    source = "/components/remote-state"
    inputs = {
      module_name = "network"
      backend     = "local"
      config = {
        path = "../network/terraform.tfstate"
      }
    }
  }

  component "firewall" {
    source = "/components/az-subscription-firewall"

    inputs = {
      hcl_reference_network  = "module.network.outputs.network"
      internet_allowed_fqdns = bundle.input.firewall_internet_allowed_fqdns.value
    }
  }
}

