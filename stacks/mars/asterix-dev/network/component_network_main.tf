// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "network" {
  cidr_range   = "192.168.1.0/24"
  context      = module.this.context
  source       = "../../../../components/az-subscription-network"
  subscription = data.terraform_remote_state.subscription.outputs.subscription
}
output "network" {
  value = module.network
}
