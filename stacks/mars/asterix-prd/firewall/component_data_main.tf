// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

resource "terraform_data" "data_dependencies" {
}
data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../network/terraform.tfstate"
  }
  depends_on = [
    terraform_data.data_dependencies,
  ]
}
