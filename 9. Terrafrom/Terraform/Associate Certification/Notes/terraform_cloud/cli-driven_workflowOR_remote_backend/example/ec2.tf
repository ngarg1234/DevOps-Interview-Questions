resource "aws_instance" "demo"{
    ami = "ami-0261755bbcb8c4a84"
    instance_type = "t2.micro"
    tags = {
        Name = "demo_remotebackend"
    }
}


provider "aws"{
    region = "us-east-1"
}
