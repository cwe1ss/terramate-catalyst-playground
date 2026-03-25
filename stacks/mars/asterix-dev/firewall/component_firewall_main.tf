// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "firewall" {
  context = module.this.context
  internet_allowed_fqdns = [
    "terramate.io",
    "example.org",
    "example.com",
  ]
  network = data.terraform_remote_state.network.outputs.network
  source  = "../../../../modules/az-subscription-firewall"
}
output "firewall" {
  value = module.firewall
}
