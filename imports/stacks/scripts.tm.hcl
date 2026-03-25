script "build" {
  name = "Build Terraform stacks"

  job {
    commands = [
      ["terraform", "init"],
      ["terraform", "fmt"],
      ["terraform", "validate"],
    ]
  }
}

script "deploy" {
  name = "Deploy Terraform stacks"

  job {
    commands = [
      ["terraform", "init"],
      ["terraform", "apply"],
    ]
  }
}
