resource "aws_instance" "test"{
    ami = "ami-0261755bbcb8c4a84"
    instance_type = "t2.micro"
    tags = {
        Name = "demo"
    }
}


resource "aws_instance" "alias_test"{
    ami = "ami-0261755bbcb8c4a84"
    instance_type = "t2.micro"
    tags = {
        Profile = "dev_profile"
    }
    provider = "aws.dev_profile"
}