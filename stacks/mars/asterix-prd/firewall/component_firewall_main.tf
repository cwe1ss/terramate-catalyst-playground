// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "firewall" {
  internet_allowed_fqdns = [
    "terramate.io",
    "example.org",
  ]
  context = module.this.context
  network = module.network.outputs.network
  source  = "../../../../components/az-subscription-firewall"
}
output "firewall" {
  value = module.firewall
}
