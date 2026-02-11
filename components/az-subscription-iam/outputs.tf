output "groups" {
  value = {
    for key, value in var.groups : key => {
      group_id           = terraform_data.group[key].id
      group_name         = terraform_data.group[key].output.name
      role_assignment_id = terraform_data.role_assignment[key].id
    }
  }
}
