output "internet_url_category_id" {
  value = terraform_data.internet_url_category.id
}

output "internet_url_category_name" {
  value = terraform_data.internet_url_category.output.name
}

output "internet_rule_id" {
  value = terraform_data.internet_rule.id
}

output "internet_rule_name" {
  value = terraform_data.internet_rule.output.name
}
