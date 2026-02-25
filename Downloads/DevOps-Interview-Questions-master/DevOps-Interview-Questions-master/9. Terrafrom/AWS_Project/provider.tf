terraform {
  required_version = ">= 1.0.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    # Add other providers as needed
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile  # Reference a variable for the profile name
  version = "~> 4.0"  # Example: adjust the version constraint for the AWS provider
}