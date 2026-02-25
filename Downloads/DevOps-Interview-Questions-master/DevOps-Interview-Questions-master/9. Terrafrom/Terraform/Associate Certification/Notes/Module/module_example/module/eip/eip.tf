resource "aws_eip" "example" {
  instance = var.instance_id
}

output "elastic_ip" {
    value = aws_eip.example.public_ip
}
variable "instance_id" {
    default = ""
}