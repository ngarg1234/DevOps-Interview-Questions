variable instance_type {
  type        = list
  default     = ["t2.large", "t2.nano", "t2.micro", "t2.small"]
  description = "description"
}

resource "aws_instance" "test_instance"{
     for_each = toset(var.instance_type)
     ami = "ami-0261755bbcb8c4a84"
     instance_type = each.key
     tags = {
        Name = "test.${each.key}"
     }
     
 }
