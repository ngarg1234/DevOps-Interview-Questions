# modules/vpc/variables.tf
variable "cidr_block" {
  description = "CIDR block for the VPC"
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames for the VPC"
# modules/vpc/outputs.tf
output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
}
  default     = true
}
