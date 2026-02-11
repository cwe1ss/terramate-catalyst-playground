locals {
  tenant = var.tenant != "" ? var.tenant : var.context.tenant
  stage  = var.stage != "" ? var.stage : var.context.stage
  names  = concat(var.context.names, var.names)

  resource_name = join("-", compact([var.resource_prefix, local.tenant, join("-", local.names), local.stage]))

  context = {
    tenant = local.tenant
    stage  = local.stage
    names  = local.names
  }
}
