define "component" {
  metadata {
    class   = "components/terraform-module"
    version = "1.0.0"
    name    = "terraform-module"
  }

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

  input "providers" {
    type        = map(string)
    default     = {}
    description = "Meta-argument for explicit mapping of providers which the module uses."
  }
}
