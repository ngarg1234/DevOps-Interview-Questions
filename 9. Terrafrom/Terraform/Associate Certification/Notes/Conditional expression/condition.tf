provider aws {
    region = "us-east-1"
}

variable "env"{
    type = string
    default = "dev"
}

resource "aws_instance" "test"{
    count = var.env == "dev" ? 2 : 3
    ami = "ami-0261755bbcb8c4a84"
    instance_type = var.env == "dev" ? "t2.micro" :  "t2.large"
}