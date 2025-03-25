variable "vpc_name" {
    type = string
    default = "db_vpc_ec2"
}

variable "aws_region" {
    type = string
    default = "eu-west-1"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.56.0.0/16"
}


variable "private_subnets_cidr" {
  type        = string
  default     = "10.56.24.0/22"
}


variable "public_subnets_cidr" {
  type        = string
  default     = "10.56.28.0/22"
}
