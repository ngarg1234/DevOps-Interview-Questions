locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    ### this line is very important 
    ### this is used for attching nodes with the cluster
    - rolearn: ${aws_iam_role.eks-node.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
    - rolearn: arn:aws:iam::228699574855:role/Shyam_Role
      username: Shyam_role
      groups:
        - system:bootstrappers
        - system:nodes
        - system:masters
  mapUsers: |
    - userarn: arn:aws:iam::228699574855:root
      username: root_user
      groups:
        - system:masters
    - userarn: arn:aws:iam::228699574855:user/Shyam
      username: shyam
      groups:
        - system:masters
CONFIGMAPAWSAUTH
}



output "config_map_aws_auth" {
  value = "${local.config_map_aws_auth}"
}

# locals {
#   kubeconfig = <<KUBECONFIG


# # apiVersion: v1
# # clusters:
# # - cluster:
#     server: ${aws_eks_cluster.eks.endpoint}
#     certificate-authority-data: ${aws_eks_cluster.eks.certificate_authority.0.data}
#   name: kubernetes
# contexts:
# - context:
#     cluster: kubernetes
#     user: aws
#   name: aws
# current-context: aws
# kind: Config
# preferences: {}
# users:
# - name: aws
#   user:
#     exec:
#       apiVersion: client.authentication.k8s.io/v1alpha1
#       command: aws-iam-authenticator
#       args:
#         - "token"
#         - "-i"
#         - "${var.cluster_name}"
# KUBECONFIG
# }

# output "kubeconfig" {
#   value = "${local.kubeconfig}"
# }
