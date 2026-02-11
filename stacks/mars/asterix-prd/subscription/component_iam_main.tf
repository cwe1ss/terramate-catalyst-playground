// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "iam" {
  groups = {
    admin = {
      role = "admin"
      users = [
        "admin@example.org",
      ]
    }
    readonly = {
      role = "readonly"
      users = [
        "cto@example.org",
      ]
    }
  }
  context      = module.this.context
  source       = "../../../../components/az-subscription-iam"
  subscription = module.subscription
}
output "iam" {
  value = module.iam
}
