terraform {
    backend "s3" {
        bucket = "terraform-shyam"
        key = "demo/demo.tfstate"
        region = "us-east-1"
        dynamodb_table = "terraform_lock"
    }
}