# TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "subscription" {
  budget_amount = 200
  context       = module.this.context
  resource_providers = [
    "Microsoft.Network",
    "Microsoft.Consumption",
  ]
  source = "../../../../modules/az-subscription"
}
output "subscription" {
  value = module.subscription
}
