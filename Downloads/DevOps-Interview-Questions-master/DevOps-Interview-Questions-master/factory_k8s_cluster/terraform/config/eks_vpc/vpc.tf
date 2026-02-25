module  "vpc" {
    source = "../../modules/vpc"
    vpc_cidr_block = local.vpc_cidr[terraform.workspace]
    vpc_name = local.vpc_name[terraform.workspace]
    vpc_environment = local.vpc_environment[terraform.workspace]
}
