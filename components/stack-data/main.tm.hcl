generate_hcl "main.tf" {
  content {
    tm_dynamic "resource" {
      condition = tm_anytrue([
        for key, value in component.input.stacks.value : value.defer_first_read
      ])

      labels     = ["terraform_data", "data_dependencies"]
      attributes = {}
    }

    tm_dynamic "data" {
      for_each = component.input.stacks.value
      iterator = each

      labels = ["terraform_remote_state", each.key]
      attributes = tm_merge(
        {
          backend = tm_coalesce(each.value.backend, global.terraform.backend.type)
          config  = each.value.config
        },
        each.value.defer_first_read ? {
          depends_on = [
            tm_hcl_expression("terraform_data.data_dependencies")
          ]
        } : {}
      )
    }
  }
}
