data "terraform_remote_state" "eip" {
    backend = "s3"
    config = {     
        bucket = "shyam-terraform"
        key    = "network_project/eip.tfstate"
        region = "us-east-1"
    }
}