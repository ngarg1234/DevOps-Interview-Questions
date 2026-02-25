terraform {
  cloud {
    organization = "Terraform_shyam"

    workspaces {
      name = "remote_backend"
    }
  }
}