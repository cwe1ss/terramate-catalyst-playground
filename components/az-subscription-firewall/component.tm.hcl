define "component" "metadata" {
  class   = "components/az-subscription-firewall"
  version = "1.0.0"
  name    = "az-subscription-firewall"
}

define "component" {
  input "hcl_reference_network" {
    type = string
  }
  input "internet_allowed_fqdns" {
    type        = list(string)
    description = "Allowed FQDNs for outbound internet access via HTTPS"
  }
}

generate_hcl "main.tf" {
  content {
    module "firewall" {
      source  = tm_source(".")
      context = module.this.context
      network = tm_hcl_expression(component.input.hcl_reference_network.value)

      internet_allowed_fqdns = component.input.internet_allowed_fqdns.value
    }

    output "firewall" {
      value = module.firewall
    }
  }
}
