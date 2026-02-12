generate_hcl "main.tf" {
  content {
    resource "terraform_data" "data_dependencies" {
    }

    tm_dynamic "data" {
      for_each = component.input.components.value
      iterator = each

      labels = ["terraform_remote_state", each.key]

      content {
        backend = each.value.backend
        config  = each.value.config

        depends_on = [terraform_data.data_dependencies]
      }
    }
  }
}
