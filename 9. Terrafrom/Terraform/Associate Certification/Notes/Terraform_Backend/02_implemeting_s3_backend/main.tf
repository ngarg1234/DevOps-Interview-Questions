provider aws{
  region ="us-east-1"
}


resource "aws_instance" "test"{
    instance_type = "t2.micro"
    ami = "ami-0261755bbcb8c4a84"  
}