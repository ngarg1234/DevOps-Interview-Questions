
provider "aws"{
    region = "us-east-1"
}

import {
    to = aws_security_group.import_test
    id = "sg-0d65eec82c5877949"
}


