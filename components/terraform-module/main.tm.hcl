generate_hcl "main.tf" {

  lets {
    config         = component.input.merge_configuration.value
    default_values = let.config.defaults

    input_values = {
      for key, value in component.input.variables.value : key => value
      if value != null && value != {}
    }

    variables_merged = tm_merge(
      let.default_values,
      # Calculate combined lists
      {
        for key, value in let.input_values : key => tm_concat(tm_try(let.default_values[key], []), let.input_values[key])
        if tm_contains(let.config.concat_keys, key)
      },
      # Calculate union for sets
      {
        for key, value in let.input_values : key => tm_setunion(tm_try(let.default_values[key], []), let.input_values[key])
        if tm_contains(let.config.setunion_keys, key)
      },
      # Other values
      {
        for key, value in let.input_values : key => value
        if !tm_contains(let.config.concat_keys, key) && !tm_contains(let.config.setunion_keys, key)
      },
    )
  }

  content {

    tm_dynamic "module" {
      labels = [component.input.module_name.value]

      attributes = tm_merge(
        # Arguments that are required for all modules
        {
          source = tm_source(component.input.module_source.value)
        },
        # Optional meta-arguments
        tm_length(component.input.providers.value) > 0 ? {
          providers = {
            for provider, value in component.input.providers.value : provider => tm_hcl_expression(value)
          }
        } : {},
        # Arguments that need to be generated as HCL expressions (e.g. references to other modules, locals, etc.)
        {
          for key, value in component.input.hcl_variables.value : key => tm_hcl_expression(value)
          if value != null
        },
        # Any other arguments for the module call
        let.variables_merged,
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
