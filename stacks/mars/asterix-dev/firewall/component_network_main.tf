// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

module "network" {
  backend = "local"
  config = {
    path = "../network/terraform.tfstate"
  }
  source = "../../../../components/remote-state"
}
