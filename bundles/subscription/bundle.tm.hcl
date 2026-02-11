define bundle metadata {
  class   = "subscription/v1"
  version = "1.0.0"

  name        = "Azure Subscription"
  description = <<-EOF
    Creates and manages an Azure subscription.
  EOF
}

define bundle {

  environments {
    required = true
  }

  scaffolding {
    path = "/configs/${bundle.input.tenant.value}-${bundle.input.project.value}.tm.yml"
    name = tm_join("-", tm_slug([bundle.input.tenant.value, bundle.input.project.value]))
  }
}
