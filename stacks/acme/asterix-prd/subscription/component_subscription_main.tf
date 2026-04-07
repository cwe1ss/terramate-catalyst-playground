# TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "subscription" {
  budget_amount = 500
  context       = module.this.context
  resource_providers = [
    "Microsoft.Consumption",
    "Microsoft.Network",
    "Microsoft.Security",
  ]
  source = "../../../../modules/az-subscription"
}
output "subscription" {
  value = module.subscription
}
