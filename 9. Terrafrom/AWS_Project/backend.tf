terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"        # Your S3 bucket name
    key            = "/my/"       # Path where the state file will be stored in the bucket
    region         = "us-west-2"                         # AWS region
    encrypt        = true                                # Enable encryption at rest
    dynamodb_table = "my-locking-table"                 # DynamoDB table for state locking
    acl            = "private"                          # ACL permissions for the state file
  }
}