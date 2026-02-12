// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "firewall" {
  context = module.this.context
  internet_allowed_fqdns = [
    "terramate.io",
    "example.org",
  ]
  network = data.terraform_remote_state.network.outputs.network
  source  = "../../../../components/az-subscription-firewall"
}
output "firewall" {
  value = module.firewall
}
