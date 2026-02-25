locals {
    vpc_name = {
        factory = "eksfactory"
        tostring("deploy.test-mgmt") = "test_mgmt_vpc_mgmt"
    }
    
    vpc_cidr = {
        dev = "10.55.0.0"
        preprod = "10.45.0.0"
        prod = "10.35.0.0"
    }
    ######## ---->>>>> Create this tag
    aws_region = "eu-west-1"

    access_key = {
        dev = "devkey"
        prod = "prodkey"
    }

    vpc_environment = {
        dev = "factory"
            ######## ---->>>>> Create this tag
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



