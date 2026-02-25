data "terraform_remote_state" "eip"{
    backend = "remote"
    config = {
        organization = "Terraform_shyam"
        workspaces = {
            name = "networking_project"
        }
    }
}