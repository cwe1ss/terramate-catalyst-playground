module "internet_url_category_context" {
  source          = "../resource-context"
  context         = var.context
  resource_prefix = "url"
  names           = ["internet"]
}

module "internet_rule_context" {
  source          = "../resource-context"
  context         = var.context
  resource_prefix = "rule"
  names           = ["internet"]
}

resource "terraform_data" "internet_url_category" {
  input = {
    name  = module.internet_url_category_context.resource_name
    fqdns = var.internet_allowed_fqdns
  }
}

resource "terraform_data" "internet_rule" {
  input = {
    name            = module.internet_rule_context.resource_name
    action          = "allow"
    source          = var.network.vnet_cidr_range
    destination     = "0.0.0.0/0"
    service         = "https"
    url_category_id = terraform_data.internet_url_category.id
  }
}

