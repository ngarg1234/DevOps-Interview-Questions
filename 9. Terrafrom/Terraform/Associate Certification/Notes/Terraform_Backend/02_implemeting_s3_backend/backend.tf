terraform {
    backend  "s3" {
        bucket = "shyam-test2"
        key  = "statefiles/test.tfstate"
        region = "us-east-1"
    }
}

