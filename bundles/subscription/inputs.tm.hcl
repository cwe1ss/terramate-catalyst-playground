define bundle {
  input "tenant" {
    type        = string
    prompt      = "Tenant"
    description = "Choose the tenant to which this project belongs"
    allowed_values = [
      for k, v in global.tenants : { name = v, value = k }
    ]
    required_for_scaffold = true
    multiselect           = false
  }

  input "project" {
    type                  = string
    prompt                = "Project name"
    description           = "Choose a project name (lowercase)"
    required_for_scaffold = true

    # TODO: How to ensure the value is lowercase? Terraform "validation" blocks would be great.
  }

  input "stage" {
    type        = string
    prompt      = "Stage"
    description = "Choose a stage"
    allowed_values = [
      for k, v in global.stages : { name = v, value = k }
    ]
    required_for_scaffold = true
    multiselect           = false
  }

  input "budget_amount" {
    type        = number
    prompt      = "Monthly budget"
    description = "Enter the monthly budget in EUR"
  }

  input "resource_providers" {
    type        = set(string)
    prompt      = "Resource Providers"
    description = "Resource providers for the subscription"
  }

  input "iam_admin_users" {
    type        = list(string)
    prompt      = "IAM: Admin Users"
    description = "Please enter a list of admins"
  }

  input "iam_readonly_users" {
    type        = list(string)
    prompt      = "IAM: ReadOnly Users"
    description = "Please enter a list of readonly users"
  }

  input "network_cidr_range" {
    type        = string
    prompt      = "Network: CIDR Range"
    description = "Optional: Enter a CIDR range if this project should get a VNet"
  }

  input "firewall_internet_allowed_fqdns" {
    type        = set(string)
    prompt      = "Network Firewall: Allowed Internet FQDNs"
    description = "Enter the FQDNs which this workload is allowed to access"
  }
}
