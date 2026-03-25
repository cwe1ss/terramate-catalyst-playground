globals "terraform" {
  version = "~> 1.14.1"
  backend = {
    type = "local"
  }
}

# Options for the Terramate UI
globals "terramate" "prompt" {
  tenants = {
    "acme"   = "Acme Corp"
    "zenith" = "Zenith Corp"
  }
}

