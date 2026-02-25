provider aws{
  region ="us-east-1"
}

variable instance_type {
  type        = list
  default     = ["t2.nano", "t2.micro", "t2.small"]
  description = "description"
}
#method 1
# resource "aws_instance" "test_instance"{
#     count = length(var.instance_type)
#     ami = "ami-0261755bbcb8c4a84"
#     instance_type = var.instance_type[count.index]
# }

#method2

# resource "aws_instance" "test_instance"{
#     count = length(var.instance_type)
#     ami = "ami-0261755bbcb8c4a84"
#     instance_type = element(var.instance_type, count.index)
# }

#method3
resource "aws_instance" "test_instance"{
    #count = length(var.instance_type)
    ami = "ami-0261755bbcb8c4a84"
    for_each      = toset(var.instance_type)
    instance_type = each.value
}

# when i removed toset anf given  for_each = var.instance_type, i got the following error
# The given "for_each" argument value is unsuitable: the "for_each" argument
# must be a map, or set of strings, and you have provided a value of type list of string.
