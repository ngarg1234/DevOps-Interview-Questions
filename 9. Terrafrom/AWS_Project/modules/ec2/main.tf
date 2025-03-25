# modules/ec2/main.tf
resource "aws_instance" "app_server" {
  ami           = "ami-12345678"
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[0]
  associate_public_ip_address = true

  tags = {
    Name = "App Server"
  }
}

output "public_ip" {
  value = aws_instance.app_server.public_ip
}
