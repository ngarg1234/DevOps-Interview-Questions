resource "aws_vpc" "vpc" {
     cidr_block = var.vpc_cidr_block
     enable_dns_hostnames = true

     tags = {
         Name = var.vpc_name
     }
 }

 resource "aws_internet_gateway" "ig"{
     vpc_id =aws_vpc.vpc.id

     tags ={
         Name = var.vpc_name
     }
 }

resource "aws_route_table" "db_on_ec2_rt_table" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.vpc_name}_rt"
    }
}

resource "aws_route_table" "db_on_ec2_rt_table_public" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.vpc_name}_rt_public"
    }
}

 resource "aws_route" "route"{
     route_table_id = aws_route_table.db_on_ec2_rt_table_public.id
     destination_cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.ig.id
 }

resource "aws_eip" "nat_eip" {
    tags = {
        Name = "db_ec2_nat_ep"
    }
}

# resource "aws_internet_gateway" "eks" {
#     vpc_id = data.aws_vpc.eks_vpc.id
#     tags = {
#         Name = "eks"
#     }
# }

resource "aws_nat_gateway" "natgw" {
    allocation_id =aws_eip.nat_eip.id
    subnet_id = aws_subnet.eks_subnet_private.id
    tags = {
        Name = "eu-west-1"
    }
}

resource "aws_route_table_association" "private_rtas" {
    subnet_id = aws_subnet.eks_subnet_private.id
    route_table_id = aws_route_table.db_on_ec2_rt_table.id
}

resource "aws_route_table_association" "public_rtas" {
    subnet_id = aws_subnet.eks_subnet_public.id
    route_table_id = aws_route_table.db_on_ec2_rt_table_public.id
}



resource "aws_route" "nat_internet" {
    route_table_id = aws_route_table.db_on_ec2_rt_table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
}

 resource "aws_subnet" "eks_subnet_private" {
    availability_zone = "eu-west-1b"
    vpc_id   = aws_vpc.vpc.id
    cidr_block = var.private_subnets_cidr
    tags = {
     Name = "ec2_db_ssubnet_private"
}
}
 resource "aws_subnet" "eks_subnet_public" {
    availability_zone = "eu-west-1a"
    vpc_id   = aws_vpc.vpc.id
    cidr_block = var.public_subnets_cidr
    tags = {
     Name = "ec2_db_ssubnet_public"
}
}
