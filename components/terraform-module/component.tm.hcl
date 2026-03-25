define "component" "metadata" {
  class   = "components/terraform-module"
  version = "1.0.0"
  name    = "terraform-module"
}

define "component" {
  input "module_source" {
    type        = string
    description = "Path to the Terraform module"
  }
  input "module_name" {
    type        = string
    description = "Name that should be used for the module call (`module \"{module_name}\" {}`)"
  }
  input "hcl_variables" {
    type        = map(string)
    description = "Module variables that will use `{key} = tm_hcl_expression({value})`."
  }
  input "variables" {
    type        = map(any)
    description = "Module variables that will use `{key} = {value}`."
  }
}

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
        }
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
