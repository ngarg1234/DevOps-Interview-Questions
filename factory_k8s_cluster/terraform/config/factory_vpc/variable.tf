variable "aws_profile" {
  type        = string
  default     = "shyamjith"
  
}
variable "aws_region" {
  type        = string
  default     = "eu-west-1"
  
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.55.0.0/16"
}

variable "vpc_name" {
  type        = string
  default     = "eksfactory"
}

variable vpc_environment {
  type        = string
  default     = "factory"
}