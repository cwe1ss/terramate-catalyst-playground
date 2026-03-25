output "subscription_id" {
  value = var.subscription.subscription_id
}

output "vnet_id" {
  value = terraform_data.vnet.id
}

output "vnet_name" {
  value = terraform_data.vnet.output.name
}

output "vnet_cidr_range" {
  value = terraform_data.vnet.output.cidr_range
}
