resource "aws_instance" "demo" {
    ami = local.ami
    instance_type = var.instance_type
    tags = {
        name = local.tags
    }
}