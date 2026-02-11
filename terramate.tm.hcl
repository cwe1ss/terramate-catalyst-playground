terramate {
  config {
    disable_safeguards = ["git"]
  }
}

import {
  source = "imports/mixins/*.tm.hcl"
}

environment {
  id          = "dev" # [A-Za-z0-9]+
  name        = "Development"
  description = "Development Environment"
}

environment {
  id           = "prd"
  name         = "Production"
  description  = "Production Environment"
  promote_from = "dev"
}
