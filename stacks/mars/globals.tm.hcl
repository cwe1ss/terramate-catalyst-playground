# Defines defaults for components based on the stage, etc.

globals "component_defaults" "subscription" {
  budget_amount = tm_contains(terramate.stack.tags, "stage/prd") ? 500 : 100

  resource_providers = [
    "Microsoft.Consumption",
  ]
}
