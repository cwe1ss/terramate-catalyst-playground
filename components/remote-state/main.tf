variable "backend" {
  type = string
}
variable "config" {
  type = any
}

resource "terraform_data" "dependencies" {
}

data "terraform_remote_state" "this" {
  backend = var.backend
  config  = var.config

  depends_on = [terraform_data.dependencies]
}

output "outputs" {
  value = data.terraform_remote_state.this.outputs
}
