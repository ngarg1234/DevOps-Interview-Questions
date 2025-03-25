# modules/rds/variables.tf
variable "db_subnet_ids" {
  description = "List of DB subnet IDs"
  type        = list(string)
}

variable "db_instance_class" {
  description = "RDS DB instance class"
}
