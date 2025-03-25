resource "aws_security_group" "eks_node_to_node" {
  name        = "${var.cluster_name}_node_to_node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${data.aws_vpc.eks_vpc.id}"

  tags = "${
    map(
     "Name", "${var.cluster_name}_node_to_node",
     "kubernetes.io/cluster/${var.cluster_name}", "owned",
    )
  }"
}


resource "aws_security_group_rule" "eks_node_to_node_egress" {
  security_group_id = "${aws_security_group.eks_node_to_node.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# resource "aws_security_group_rule" "eks_node_to_node_ingress_primary" {
#   security_group_id = "${aws_security_group.eks_node_to_node.id}"
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["${data.aws_vpc.eks_vpc.cidr_block_associations.0.cidr_block}"]
# }

# resource "aws_security_group_rule" "eks_node_to_node_ingress_secondary" {
#   count             = "${length(data.aws_vpc.eks_vpc.cidr_block_associations) == 2 ? 1 : 0}"
#   security_group_id = "${aws_security_group.eks_node_to_node.id}"
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["${data.aws_vpc.eks_vpc.cidr_block_associations.1.cidr_block}"]
# }


resource "aws_security_group_rule" "eks_node_ingress_self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.eks_node_to_node.id}"
  source_security_group_id = "${aws_security_group.eks_node_to_node.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks_node_ingress_cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.eks_node_to_node.id}"
  source_security_group_id = "${aws_security_group.eks_node_to_cluster.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks_node_ingress_node_https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.eks_node_to_cluster.id}"
  source_security_group_id = "${aws_security_group.eks_node_to_node.id}"
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks_node_ingress_node_https1" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.eks_node_to_node.id}"   
  source_security_group_id = "${aws_security_group.eks_node_to_cluster.id}"
  to_port                  = 443
  type                     = "ingress"
}