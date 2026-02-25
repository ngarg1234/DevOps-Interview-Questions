terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket ="terraform.state2"
    key = "ec2_db_vpc"
    region = "eu-west-1"
    profile = "shyamjith"
  }
  
}
