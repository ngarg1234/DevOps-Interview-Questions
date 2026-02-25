# data "aws_ami" "eks_node" {
#   filter {
#     name   = "name"
#     #values = ["amazon-eks-node-${aws_eks_cluster.eks.version}-v*"]
#     #values = ["amazon-eks-*"]
#      #values = ["eks-worker-*"]
#      values = ["amazon-eks-node-*"]
#   }

#   most_recent = true
#   owners      = ["${var.node_ami_owner}"]
# }

locals {
  eks_node_userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.eks.endpoint}' --b64-cluster-ca '${aws_eks_cluster.eks.certificate_authority.0.data}' '${var.cluster_name}'
USERDATA
}

resource "aws_launch_template" "eks" {
  name                 = "eks-${var.cluster_name}"
 

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20  # Adjust the volume size as needed
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"  # Adjust as needed
  }

  credit_specification {
    cpu_credits = "standard"  # or "unlimited" if needed
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.eks_node.name
  }

  image_id                 = "ami-0414322bb6e8ec4ca"  # Change the AMI according to Kubernetes version changes 
  # find the ami id for your cluster version from here - https://github.com/awslabs/amazon-eks-ami/blob/master/CHANGELOG.md 
  # select the image for - amazon-eks-node
  instance_type            = var.node_size
  key_name                 = var.key_name
  vpc_security_group_ids   = aws_security_group.eks_node_to_node[*].id
  user_data                = base64encode(local.eks_node_userdata)

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "eks-${var.cluster_name}"
      Environment = "production"  # Adjust as needed
    }
  }
}


resource "aws_autoscaling_group" "eks" {
  count                = "${length(var.subnets)}"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  name                 = "eks-${var.cluster_name}-${element(aws_subnet.eks_subnet-private.*.availability_zone, count.index)}"
  vpc_zone_identifier  = ["${element(aws_subnet.eks_subnet-private.*.id, count.index)}"]
  termination_policies = ["NewestInstance", "OldestLaunchConfiguration"]
  launch_template {
    id      = aws_launch_template.eks.id
  }

  tag {
    key                 = "Name"
    value               = "eks-${var.cluster_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/enabled"
    value               = ""
    propagate_at_launch = true
  }
}
