resource "aws_security_group" "before_dynamic_block" {
    name = "sample_sg2"

    ingress {
        from_port = "22"
        to_port = "22"
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = "3369"
        to_port = "3369"
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = "80"
        to_port = "80"
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

     ingress {
        from_port = "8080"
        to_port = "8080"
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    egress {
        from_port = "22"
        to_port = "22"
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = "3369"
        to_port = "3369"
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = "80"
        to_port = "80"
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

     egress {
        from_port = "8080"
        to_port = "8080"
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}