

data "aws_security_group" "example" {
  filter {
    name   = "tag:Name"  # Tag key
    values = ["terraform1"]     # Tag value
  }
}

resource "aws_instance" "test-var" {
    instance_type = var.size
    ami = var.ami-id
    key_name         = "terraform"              # Replace with your key pair
    vpc_security_group_ids = [data.aws_security_group.example.id]  # Correct security group ID
    tags = {
        Name = local.instance_name
    }
}


output "ec2PublicIP" {
    value = aws_instance.test-var.public_ip
}

output "security_group_id" {
  value = data.aws_security_group.example.id
}

