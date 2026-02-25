terraform {
    backend "s3" {
        bucket = "shyamjith1"
        key = "vpc"
        region = "us-east-2"
    }
}