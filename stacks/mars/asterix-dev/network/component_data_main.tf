// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

resource "terraform_data" "data_dependencies" {
}
data "terraform_remote_state" "subscription" {
  backend = "local"
  config = {
    path = "../subscription/terraform.tfstate"
  }
  depends_on = [
    terraform_data.data_dependencies,
  ]
}
