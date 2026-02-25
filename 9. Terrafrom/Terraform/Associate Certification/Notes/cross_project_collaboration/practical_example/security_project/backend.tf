provider "aws" {
    region = "us-east-1"
}

terraform {
    backend "s3" {
        bucket = "shyam-terraform"
        key    = "security_project/sg.tfstate"
        region = "us-east-1"
    }
}