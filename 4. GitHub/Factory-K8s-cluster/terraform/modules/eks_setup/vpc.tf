data "aws_vpc" "eks_vpc" {
    id = var.vpc_id
}

data "aws_internet_gateway" "ig"{
    filter {
        name = "attachment.vpc-id"
        values = [var.vpc_id]
    }
}

resource "aws_subnet" "eks_subnet-private" {
    count = length(var.subnets)
    availability_zone = "${var.aws_region}${lookup(var.subnets[count.index], "availability_zone")}"
    vpc_id   = data.aws_vpc.eks_vpc.id
    cidr_block = lookup(var.subnets[count.index], "cidr_block")
    tags = "${
        map(
         "Name", "${var.cluster_name}_private_${lookup(var.subnets[count.index], "availability_zone")}",
         "kubernetes.io/cluster/${var.cluster_name}", "owned",
         "kubernetes.io/role/internal-elb", "1",
        )
    }"
}

resource "aws_subnet" "eks_subnet-public" {
    count = length(var.subnets_public)
    availability_zone = "${var.aws_region}${lookup(var.subnets_public[count.index], "availability_zone")}"
    vpc_id   = data.aws_vpc.eks_vpc.id
    cidr_block = lookup(var.subnets_public[count.index], "cidr_block")
    map_public_ip_on_launch = true
    tags = "${
        map(
         "Name", "${var.cluster_name}_public_${lookup(var.subnets[count.index], "availability_zone")}",
         "kubernetes.io/cluster/${var.cluster_name}", "owned",
         "kubernetes.io/role/elb", "1",
        )
    }"
}

resource "aws_eip" "nat_eip" {
    count = length(var.subnets)
    depends_on = [data.aws_internet_gateway.ig]
    tags = {
        Name = "nat_${lookup(var.subnets[count.index], "availability_zone")}"
    }
}

# resource "aws_internet_gateway" "eks" {
#     vpc_id = data.aws_vpc.eks_vpc.id
#     tags = {
#         Name = "eks"
#     }
# }

resource "aws_nat_gateway" "natgw" {
    count = length(var.subnets)
    allocation_id =aws_eip.nat_eip[count.index].id
    subnet_id = aws_subnet.eks_subnet-public[count.index].id
    tags = {
        Name = "Nat_Gw_${lookup(var.subnets[count.index], "availability_zone")}"
    }
}

resource "aws_route_table" "eks_route_table-private" {
    count = length(var.subnets)
    vpc_id = data.aws_vpc.eks_vpc.id
    tags = {
        Name = "eks_private_rt_${lookup(var.subnets[count.index], "availability_zone")}"
    }
}

resource "aws_route_table" "eks_route_table-public" {
    count = length(var.subnets)
    vpc_id = data.aws_vpc.eks_vpc.id
    tags = {
        Name = "eks_public_rt_${lookup(var.subnets[count.index], "availability_zone")}"
    }
}

resource "aws_route" "nat_internet" {
    count = length(var.subnets)
    route_table_id = aws_route_table.eks_route_table-private[count.index].id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw[count.index].id
}

resource "aws_route" "pub_subnet" {
    count = length(var.subnets_public)
    route_table_id = aws_route_table.eks_route_table-public[count.index].id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.ig.id
}

resource "aws_route_table_association" "public_rtas" {
    count = length(var.subnets_public)
    subnet_id = aws_subnet.eks_subnet-public[count.index].id
    route_table_id = aws_route_table.eks_route_table-public[count.index].id
}

resource "aws_route_table_association" "private_rtas" {
    count = length(var.subnets)
    subnet_id = aws_subnet.eks_subnet-private[count.index].id
    route_table_id = aws_route_table.eks_route_table-private[count.index].id
}