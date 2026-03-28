generate_hcl "main.tf" {
  content {
    tm_dynamic "module" {
      labels = [component.input.module_name.value]
      attributes = tm_merge(
        {
          source = tm_source(component.input.module_source.value)
        },
        {
          for key, value in component.input.hcl_variables.value : key => tm_hcl_expression(value)
          if value != null
        },
        {
          for key, value in component.input.variables.value : key => value
          if value != null
        },
        tm_length(component.input.providers.value) > 0 ? {
          providers = {
            for provider, value in component.input.providers.value : provider => tm_hcl_expression(value)
          }
        } : {},
      )
    }

    tm_dynamic "output" {
      labels = [component.input.module_name.value]
      content {
        value = tm_hcl_expression("module.${component.input.module_name.value}")
      }
    }
  }
}
