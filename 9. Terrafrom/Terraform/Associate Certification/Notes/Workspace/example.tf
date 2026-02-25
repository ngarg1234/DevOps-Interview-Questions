resource "aws_instance" "test_instance"{
     ami = "ami-0261755bbcb8c4a84"
     instance_type = lookup(var.intance_type, terraform.workspace)
     tags = {
        Name = "${terraform.workspace}"
     }
 }

variable "instance_type"{
    type = "map"
    default = {
        dev = "t2.micro"
        pre = "t2.small"
        prod = "t2.medium"
    }
}