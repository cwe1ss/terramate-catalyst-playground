generate_hcl "main.tf" {
  condition = (
    tm_length(component.input.import.value) > 0
    || tm_length(component.input.moved.value) > 0
  )

  content {

    tm_dynamic "import" {
      for_each = component.input.import.value
      iterator = each

      content {
        to = tm_hcl_expression(each.value.to)
        id = each.value.id
      }
    }

    tm_dynamic "moved" {
      for_each = component.input.moved.value
      iterator = each

      content {
        from = tm_hcl_expression(each.value.from)
        to   = tm_hcl_expression(each.value.to)
      }
    }
  }
}
