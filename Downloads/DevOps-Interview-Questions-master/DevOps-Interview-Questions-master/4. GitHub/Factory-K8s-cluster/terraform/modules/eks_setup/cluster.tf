resource "aws_eks_cluster" "eks" {
    name = var.cluster_name
    role_arn = aws_iam_role.eks.arn
    version = "1.24"
    ################ ----->>>>>>>> Change the version(this may cause error in future)
    vpc_config {
        endpoint_private_access = true
        endpoint_public_access = true
        security_group_ids      = "${list(aws_security_group.eks_node_to_cluster.id)}"
        subnet_ids = [
            aws_subnet.eks_subnet-public[0].id,
            aws_subnet.eks_subnet-public[1].id,
            aws_subnet.eks_subnet-private[0].id,
            aws_subnet.eks_subnet-private[1].id
        ]
    }
    depends_on = [
        "aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy",
        "aws_iam_role_policy_attachment.eks-AmazonEKSServicePolicy"
    ]
}
