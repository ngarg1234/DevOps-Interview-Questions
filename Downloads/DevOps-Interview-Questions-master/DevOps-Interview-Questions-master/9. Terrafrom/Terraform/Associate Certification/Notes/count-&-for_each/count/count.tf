variable instance_type {
  type        = list
  default     = ["t2.nano", "t2.micro", "t2.small"]
  description = "description"
}

resource "aws_instance" "test_instance"{
     count = length(var.instance_type)
     ami = "ami-0261755bbcb8c4a84"
     instance_type = var.instance_type[count.index]
     tags = {
        name = "test.${count.index}"
     }
     lifecycle {
      create_before_destroy = true
     }
 }


 provider aws{
  region ="us-east-1"
}

