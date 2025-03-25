locals {
    vpc_name = {
        dev = "dev"
        tostring("deploy.test-mgmt") = "test_mgmt_vpc_mgmt"
        prod = "prod"
    }

    aws_region = "eu-west-1"

    access_key  = {
        dev = "devkey"
        prod = "prodkey"
    }
    vpc_environment = {
        dev = "dev"
        prod = "prod"
    }

    subnets = {
        dev = [
            {
                availability_zone = "a"
                cidr_block = "10.55.24.0/22"
                nat_gateway_name = "eks_nat_gw_0"
                nat_subnet_name = "eks_nat_subnet_a"
            },
            {
                availability_zone = "b"
                cidr_block = "10.55.28.0/22"
                nat_gateway_name = "eks_nat_gw_1"
                nat_subnet_name = "eks_nat_subnet_b"
            },
        ]
    }
    subnets_public = {
        dev = [
            {
                availability_zone = "a"
                cidr_block = "10.55.40.0/22"
            },
            {
                availability_zone = "b"
                cidr_block = "10.55.48.0/22"
            },
        ]
    }
}



