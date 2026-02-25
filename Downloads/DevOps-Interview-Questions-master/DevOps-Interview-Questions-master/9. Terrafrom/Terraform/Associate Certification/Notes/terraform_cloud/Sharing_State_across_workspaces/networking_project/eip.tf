resource "aws_eip" "lb" {
  vpc      = true
  tags = {
    name = "demo"
  }
}

output "eip_id" {
  value = aws_eip.lb.public_ip
}