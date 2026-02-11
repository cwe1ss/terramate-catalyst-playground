define bundle {
  input "tenant" {
    type        = string
    prompt      = "Tenant"
    description = "Choose the tenant to which this project belongs"
    options = [
      for k, v in global.tenants : { name = v, value = k }
    ]
    multiselect = false
  }

  input "project" {
    type        = string
    prompt      = "Project name"
    description = "Choose a project name (lowercase)"

    # TODO: How to ensure the value is lowercase? Terraform "validation" blocks would be great.
  }

  input "stage" {
    type        = string
    prompt      = "Stage"
    description = "Choose a stage"
    options = [
      for k, v in global.stages : { name = v, value = k }
    ]
    multiselect = false
  }

  input "budget_amount" {
    type        = number
    prompt      = "Monthly budget"
    description = "Enter the monthly budget in EUR"
    default     = 0
  }

  input "resource_providers" {
    type        = set(string)
    prompt      = "Resource Providers"
    description = "Resource providers for the subscription"
    default     = []
  }

  input "iam_admin_users" {
    type        = list(string)
    prompt      = "IAM: Admin Users"
    description = "Please enter a list of admins"
    default     = []
  }

  input "iam_readonly_users" {
    type        = list(string)
    prompt      = "IAM: ReadOnly Users"
    description = "Please enter a list of readonly users"
    default     = []
  }

  input "network_cidr_range" {
    type        = string
    prompt      = "Network: CIDR Range"
    description = "Optional: Enter a CIDR range if this project should get a VNet"
    default     = ""
  }

  input "firewall_internet_allowed_fqdns" {
    type        = set(string)
    prompt      = "Network Firewall: Allowed Internet FQDNs"
    description = "Enter the FQDNs which this workload is allowed to access"
    default     = []
  }
}
