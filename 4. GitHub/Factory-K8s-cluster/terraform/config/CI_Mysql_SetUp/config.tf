terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket ="terraform.state2"
    key = "ci_build"
    region = "eu-west-1"
    profile = "shyamjith"
  }  
}
