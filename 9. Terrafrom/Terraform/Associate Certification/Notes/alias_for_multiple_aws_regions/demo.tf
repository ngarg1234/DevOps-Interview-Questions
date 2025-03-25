resource "aws_instance" "test"{
    ami = "ami-0261755bbcb8c4a84"
    instance_type = "t2.micro"
    tags = {
        Name = "demo"
    }
}


resource "aws_instance" "alias_test"{
    ami = "ami-00b7cc7d7a9f548ea"
    instance_type = "t2.micro"
    tags = {
        Name = "demo"
    }
    provider = "aws.region2"
}