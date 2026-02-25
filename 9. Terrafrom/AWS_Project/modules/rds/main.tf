# modules/rds/main.tf
resource "aws_db_instance" "main" {
  allocated_storage    = 20
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = var.db_instance_class
  db_name             = "prod_db"
  username            = "admin"
  password            = "password123"
  subnet_ids          = var.db_subnet_ids
  skip_final_snapshot = true

  tags = {
    Name = "prod-db"
  }
}
