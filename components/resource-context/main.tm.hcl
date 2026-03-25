generate_hcl "main.tf" {
  content {
    tm_dynamic "module" {
      labels = ["this"]
      attributes = tm_merge(
        {
          source = tm_source("/modules/resource-context")
        },
        {
          for key, input in component.input : key => input.value
          if input.value != null
        }
      )
    }
  }
}
