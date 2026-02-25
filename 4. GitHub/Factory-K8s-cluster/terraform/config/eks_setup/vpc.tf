data "aws_vpc" "vpc" {
    filter {
        name = "tag:Name"
        values = [local.vpc_name[terraform.workspace]]
    }

    filter {
        name = "tag:Environment"
        values = [local.vpc_environment[terraform.workspace]]
    }
}