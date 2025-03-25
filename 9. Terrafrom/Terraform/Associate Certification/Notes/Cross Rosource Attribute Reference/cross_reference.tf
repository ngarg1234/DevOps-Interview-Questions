provider aws {
    region = "us-east-1"
}

resource "aws_eip" "lb" {
    domain = "vpc"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  
  ingress {
   
    from_port   = 443
    to_port     = 443
    protocol    = "-1"
    cidr_blocks = [aws_eip.lb.public_ip/32]   # cross reference 
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = ["pl-12c4e678"]
  }
}