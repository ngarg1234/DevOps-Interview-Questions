variable map_of_instance_type {
  type        = map
  default     = {
    key1    =   "t2.micro"
    key2    =   "t2.nano"
  }
}

resource "aws_instance" "map_test_instance"{
     for_each = var.map_of_instance_type
     ami = "ami-0261755bbcb8c4a84"
     instance_type = each.value
     tags = {
        Name = "test.${each.key}"
     }
 }


 provider aws{
  region ="us-east-1"
}