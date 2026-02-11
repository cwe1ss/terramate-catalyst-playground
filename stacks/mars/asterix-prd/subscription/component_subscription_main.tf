// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "subscription" {
  budget_amount = 500
  resource_providers = [
    "Microsoft.Network",
    "Microsoft.Consumption",
  ]
  context = module.this.context
  source  = "../../../../components/az-subscription"
}
output "subscription" {
  value = module.subscription
}
