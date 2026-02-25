resource "aws_instance" "module_test" {
    instance_type = var.instance_type
    ami         = local.ami # since you used local here, this value cannot be overriden while using this module
    tags = {
        Name = "Test"
    }
}


variable "instance_type" {
    default = "t2.micro"
}

variable "public_ip" {
    default = ""
}



locals {
    ami = "ami-053b0d53c279acc90"
}


output "publicip"{
    value = aws_instance.module_test.public_ip
}

output "instanceid"{
    value = aws_instance.module_test.id
}