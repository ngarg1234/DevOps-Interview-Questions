# variables.tf
variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-01"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  default     = "t2.micro"
}

variable "db_instance_class" {
  description = "RDS DB Instance class"
  default     = "db.t2.micro"
}

variable "s3_bucket_name" {
  description = "S3 Bucket name"
  default     = "my-prod-s3-bucket"
}

variable "profile" {
  description = "MyAWSProfile"
  default = "naman"
}
