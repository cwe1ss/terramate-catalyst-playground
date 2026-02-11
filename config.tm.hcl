globals "terraform" {
  version = "~> 1.14.1"
}

globals "terraform" "backend" {
  type = "local"
}

globals {
  tenants = {
    "mars"  = "Organization Mars"
    "venus" = "Organization Venus"
  }
  stages = {
    dev = "Development"
    prd = "Production"
  }
}

