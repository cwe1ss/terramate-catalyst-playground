define bundle {
  input "network" {
    type        = object
    description = "Network configuration for the subscription"
    default     = {}

    prompt {
      text = "Network configuration"
    }

    attribute "cidr_range" {
      type        = string
      description = "Optional: Enter a CIDR range if this project should get a VNet"

      prompt {
        text = "Network: CIDR Range"
      }
    }
    attribute "internet_allowed_fqdns" {
      type        = list(string)
      description = "Enter the FQDNs which this workload is allowed to access"
      default     = []

      prompt {
        text = "Network Firewall: Allowed Internet FQDNs"
      }
    }
  }
}
