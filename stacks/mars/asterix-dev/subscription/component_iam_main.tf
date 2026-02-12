// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "iam" {
  context = module.this.context
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
  source       = "../../../../components/az-subscription-iam"
  subscription = module.subscription
}
output "iam" {
  value = module.iam
}
