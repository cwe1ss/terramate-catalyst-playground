define bundle {
  input "tenant" {
    type        = string
    immutable   = true
    description = "Choose the tenant to which this project belongs"

    prompt {
      text        = "Tenant"
      multiselect = false
      options = [
        for k, v in global.terramate.prompt.tenants : { name = v, value = k }
      ]
    }
  }

  input "project" {
    type        = string
    immutable   = true
    description = "Choose a project name (lowercase)"

    prompt {
      text = "Project name"
    }

    # TODO: How to ensure the value is lowercase? Terraform "validation" blocks would be great.
  }

  input "budget_amount" {
    type        = number
    description = "Enter the monthly budget in EUR"
    default     = 0

    prompt {
      text = "Monthly budget"
    }
  }

  input "resource_providers" {
    type        = set(string)
    description = "Resource providers for the subscription"
    default     = []

    prompt {
      text = "Resource Providers"
    }
  }

  input "iam_admin_users" {
    type        = list(string)
    description = "Please enter a list of admins"
    default     = []

    prompt {
      text = "IAM: Admin Users"
    }
  }

  input "iam_readonly_users" {
    type        = list(string)
    description = "Please enter a list of readonly users"
    default     = []

    prompt {
      text = "IAM: ReadOnly Users"
    }
  }
}
