# modules/ec2/variables.tf
variable "instance_type" {
  description = "EC2 instance type"
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}
