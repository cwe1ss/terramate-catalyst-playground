terramate {
  config {
    disable_safeguards = ["git"]
    experiments        = ["scripts"]

    generate {
      hcl_magic_header_comment_style = "#"
    }
  }
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
