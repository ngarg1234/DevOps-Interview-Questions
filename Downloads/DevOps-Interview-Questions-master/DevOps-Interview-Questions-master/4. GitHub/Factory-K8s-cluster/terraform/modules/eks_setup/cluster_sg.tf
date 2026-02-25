data "aws_security_group" "eks_vpc"{
    vpc_id = "${data.aws_vpc.eks_vpc.id}"
    name = "default"
}

resource "aws_security_group" "eks_node_to_cluster" {
  name        = "${var.cluster_name}_node_to_cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${data.aws_vpc.eks_vpc.id}"

  tags = "${
    map(
     "Name", "${var.cluster_name}_node_to_cluster",
     "kubernetes.io/cluster/${var.cluster_name}", "owned",
    )
  }"
}

resource "aws_security_group_rule" "eks_node_to_cluster_egress" {
  security_group_id = "${aws_security_group.eks_node_to_cluster.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# resource "aws_security_group_rule" "eks_node_to_cluster_ingress_primary" {
#   security_group_id = "${aws_security_group.eks_node_to_cluster.id}"
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["${data.aws_vpc.eks_vpc.cidr_block_associations.0.cidr_block}"]
# }

# resource "aws_security_group_rule" "eks_node_to_cluster_ingress_secondary" {
#   count             = "${length(data.aws_vpc.eks_vpc.cidr_block_associations) == 2 ? 1 : 0}"
#   security_group_id = "${aws_security_group.eks_node_to_cluster.id}"
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["${data.aws_vpc.eks_vpc.cidr_block_associations.1.cidr_block}"]
# }

# resource "aws_security_group_rule" "eks_ingress_node_https" {
#   description              = "Allow nodes to communicate with the cluster API Server"
#   from_port                = 443
#   protocol                 = "tcp"
#   security_group_id        = "${aws_security_group.eks_node_to_cluster.id}"
#   source_security_group_id = "${data.aws_security_group.eks_vpc.id}"
#   to_port                  = 443
#   type                     = "ingress"
# }



# OPTIONAL: Allow inbound traffic from your local workstation external IP
#           to the Kubernetes. You will need to replace A.B.C.D below with
#           your real IP. Services like icanhazip.com can help you find this.
# resource "aws_security_group_rule" "demo-cluster-ingress-workstation-https" {
#   cidr_blocks       = ["A.B.C.D/32"]
#   description       = "Allow workstation to communicate with the cluster API Server"
#   from_port         = 443
#   protocol          = "tcp"
#   security_group_id = "${aws_security_group.demo-cluster.id}"
#   to_port           = 443
#   type              = "ingress"
# }



