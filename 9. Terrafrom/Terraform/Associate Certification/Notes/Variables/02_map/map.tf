provider aws{
  region ="us-east-1"
}

variable instance_type {
  type        = map
  default     = {
    instance1 = "t2.nano"
    instance2 = "t2.small"
    instance3 = "t2.micro"
  }
}
# method 1 

# resource "aws_instance" "demo"{
#     count = length(keys(var.instance_type))
#     ami = "ami-0261755bbcb8c4a84"
#     instance_type = var.instance_type[keys(var.instance_type)[count.index]]
# }
#method 2

# resource "aws_instance" "demo"{
#     count = length(keys(var.instance_type))
#     ami = "ami-0261755bbcb8c4a84"
#     instance_type = lookup(var.instance_type, keys(var.instance_type)[count.index])
# }

resource "aws_instance" "demo"{
    count = length(keys(var.instance_type))
    ami = "ami-0261755bbcb8c4a84"
    instance_type = lookup(var.instance_type, element(keys(var.instance_type), count.index))
}

# resource "aws_s3_bucket" "example_buckets" {
#   count = length(keys(var.example_map))

#   bucket = element(keys(var.example_map), count.index)

#   tags = {
#     Name = lookup(var.example_map, element(keys(var.example_map), count.index))
#   }
# }
