module "vnet_context" {
  source          = "../resource-context"
  context         = var.context
  resource_prefix = "vnet"
}

resource "terraform_data" "vnet" {
  input = {
    subscription_id = var.subscription.subscription_id
    name            = module.vnet_context.resource_name
    cidr_range      = var.cidr_range
  }
}
