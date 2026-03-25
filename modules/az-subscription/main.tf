module "subscription_context" {
  source          = "../resource-context"
  context         = var.context
  resource_prefix = "sub"
}

resource "terraform_data" "subscription" {
  input = {
    name = module.subscription_context.resource_name
  }
}

resource "terraform_data" "resource_provider" {
  for_each = var.resource_providers

  input = {
    provider = each.key
  }
}

resource "terraform_data" "budget" {
  count = var.budget_amount > 0 ? 1 : 0

  input = {
    amount = var.budget_amount
  }
}
