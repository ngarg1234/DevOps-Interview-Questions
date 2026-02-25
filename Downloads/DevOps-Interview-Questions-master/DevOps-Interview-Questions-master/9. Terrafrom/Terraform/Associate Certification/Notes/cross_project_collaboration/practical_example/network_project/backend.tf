provider "aws" {
    region = "us-east-1"
}

terraform {
    backend "s3" {
        bucket = "shyam-terraform"
        key    = "network_project/eip.tfstate"
        region = "us-east-1"
    }
}