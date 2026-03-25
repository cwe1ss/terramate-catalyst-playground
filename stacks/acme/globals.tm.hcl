# Defines defaults for components based on the stage, etc.

globals "component_defaults" "subscription" {
  budget_amount = tm_contains(terramate.stack.tags, "environment/prd") ? 500 : 200

  resource_providers = [
    "Microsoft.Consumption",
  ]
}
