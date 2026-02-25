data "aws_ami" "test"{
    most_recent = true
    owners = ["099720109477"]
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
}
provider "aws"{
    region ="us-east-1"
}

output "ami_output" {
  value = data.aws_ami.test.id
}