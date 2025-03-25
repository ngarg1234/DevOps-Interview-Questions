# modules/vpc/variables.tf
variable "cidr_block" {
  description = "CIDR block for the VPC"
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames for the VPC"
  default     = true
}
