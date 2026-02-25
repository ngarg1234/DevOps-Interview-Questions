resource "aws_vpc" "vpc" {
     cidr_block = var.vpc_cidr_block
     enable_dns_hostnames = true

     tags = {
         Name = var.vpc_name
         Environment = var.vpc_environment
     }
 }

 resource "aws_internet_gateway" "ig"{
     vpc_id =aws_vpc.vpc.id

     tags ={
         Name = var.vpc_name
     }
 }

 resource "aws_route" "route"{
     route_table_id = aws_vpc.vpc.default_route_table_id
     destination_cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.ig.id
 }
