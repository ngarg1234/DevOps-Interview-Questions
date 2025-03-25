provider "aws"{
    region = "us-east-1"
}

resource "aws_instance" "demo"{
    ami = "ami-0261755bbcb8c4a84"
    instance_type = "t2.micro"
    tags = {
        Name = "demo"
    }
    lifecycle{
        ignore_changes = [tags]
    }
}


resource "aws_instance" "test"{
    ami = "ami-0261755bbcb8c4a84"
    instance_type = "t2.micro"
    tags = {
        Name = "demo"
    }
    lifecycle{
        ignore_changes = [tags, instance_type]
    }
}

## to ignore all the changes, you can use the option - all
resource "aws_instance" "all"{
    ami = "ami-0261755bbcb8c4a84"
    instance_type = "t2.micro"
    tags = {
        Name = "demo"
    }
    lifecycle{
        ignore_changes = all
    }
}