# modules/s3/main.tf
resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name = "prod-bucket"
  }
}
