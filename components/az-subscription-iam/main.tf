module "group_context" {
  for_each = var.groups

  source          = "../resource-context"
  context         = var.context
  resource_prefix = "grp"
  names           = [each.key]
}

resource "terraform_data" "group" {
  for_each = var.groups

  input = {
    name  = module.group_context[each.key].resource_name
    users = each.value.users
  }
}

resource "terraform_data" "role_assignment" {
  for_each = var.groups

  input = {
    subscription_id = var.subscription.subscription_id
    group_id        = terraform_data.group[each.key].id
    role            = each.value.role
  }
}
