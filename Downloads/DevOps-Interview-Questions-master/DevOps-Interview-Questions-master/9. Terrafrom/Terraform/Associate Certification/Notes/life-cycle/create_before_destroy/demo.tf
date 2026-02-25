provider "aws"{
    region = "us-east-1"
}

resource "aws_instance" "yoyo"{
    ami = "ami-0261755bbcb8c4a84"
    instance_type = "t2.micro"
    lifecycle{
        create_before_destroy =true
    }
}