
variable "sg_ports" {
    type = list(number)
    default = [22, "80", 3369, 8080, 1111]
}

resource "aws_security_group" "after_dynamic_block" {
    name = "after_dynamic_block"

    dynamic ingress {
        for_each = toset(var.sg_ports)

        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

     dynamic egress {
        for_each = var.sg_ports
        iterator = port
        content {
            from_port = port.value
            to_port = port.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}