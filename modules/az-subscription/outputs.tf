output "subscription_id" {
  value = terraform_data.subscription.id
}

output "subscription_name" {
  value = terraform_data.subscription.output.name
}

output "resource_providers" {
  value = [for key, value in terraform_data.resource_provider : value.output.provider]
}
