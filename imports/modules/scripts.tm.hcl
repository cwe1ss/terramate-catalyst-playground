script "build" {
  name = "Build Terraform modules"

  job {
    commands = [
      ["terraform", "init"],
      ["terraform", "fmt"],
      ["terraform", "validate"],
    ]
  }
}
