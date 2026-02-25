provider aws{
  region ="us-east-1"
}

variable instance_type {
  type        = list
  default     = ["t2.micro"]
  description = "description"
}

resource "aws_instance" "test_instance"{
    count = length(var.instance_type)
    #ami = "ami-0261755bbcb8c4a84"
    ami = "ami-0f34c5ae932e6f0e4"
    instance_type = var.instance_type[count.index]
    lifecycle {
    prevent_destroy = true  # Prevent destruction of existing instances
  }
}

