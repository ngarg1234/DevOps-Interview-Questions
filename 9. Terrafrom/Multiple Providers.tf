1️⃣ Using Different Providers (AWS & Azure)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "azurerm" {
  features {}
}

➡️ This configuration allows Terraform to manage both AWS and Azure resources in the same project.


2️⃣ Using Multiple Configurations of the Same Provider (Multiple AWS Accounts)
provider "aws" {
  alias  = "dev"
  region = "us-west-1"
}

provider "aws" {
  alias  = "prod"
  region = "us-east-1"
}

resource "aws_s3_bucket" "dev_bucket" {
  provider = aws.dev
  bucket   = "my-dev-bucket"
}

resource "aws_s3_bucket" "prod_bucket" {
  provider = aws.prod
  bucket   = "my-prod-bucket"
}
➡️ Here, Terraform creates two S3 buckets, one in each AWS account or region
