Cluster VPC considerations

https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html

When you create an Amazon EKS cluster, you specify the VPC subnets where Amazon EKS can place Elastic Network Interfaces. Amazon EKS requires subnets in at least two Availability Zone, and creates up to four network interfaces across these subnets to facilitate control plane communication to your node.

The Amazon EKS created cluster security group and any additional security groups that you specify when you create your cluster are applied to these network interfaces. Each Amazon EKS created network interface has Amazon EKS <cluster name> in their description.
  
 We recommend creating small (/28), dedicated subnets for Amazon EKS created network interfaces, and only specifying these subnets as part of cluster creation
  
 Other resources, such as nodes and load balancers, should be launched in separate subnets from the subnets specified during cluster creation.
 
  
Your VPC must have DNS hostname and DNS resolution support, or your nodes can't register with your cluster. For more information, see Using DNS with Your VPC in the Amazon VPC User Guide.


  
  
  https://docs.aws.amazon.com/eks/latest/userguide/create-public-private-vpc.html
  
    Public IP addresses are automatically assigned to resources deployed to one of the public subnets, but public IP addresses are not assigned to any resources         deployed to the private subnets. The nodes in private subnets can communicate with the cluster and other AWS services, and pods can communicate outbound to the     internet through a NAT gateway that is deployed in each Availability Zone. A security group is deployed that denies all inbound traffic and allows all outbound     traffic. The subnets are tagged so that Kubernetes is able to deploy load balancers to them. For more information about subnet tagging, see Subnet tagging. For     more information about this type of VPC, see VPC with public and private subnets (NAT).
  
  
  
  
Important
  
  
Nodes and load balancers can be launched in any subnet in your cluster’s VPC, including subnets not registered with Amazon EKS during cluster creation. Subnets do not require any tags for nodes. For Kubernetes load balancing auto discovery to work, subnets must be tagged as described in Subnet tagging.

Subnets associated with your cluster cannot be changed after cluster creation. If you need to control exactly which subnets the Amazon EKS created network interfaces are placed in, then specify only two subnets during cluster creation, each in a different Availability Zone.

Do not select a subnet in AWS Outposts, AWS Wavelength, or an AWS Local Zone when creating your cluster.

Clusters created using v1.14 or earlier contain a "kubernetes.io/cluster/<cluster-name> tag on your VPC. This tag was only used by Amazon EKS and can be safely removed.

An updated range caused by adding CIDR blocks to an existing cluster can take as long as 5 hours to appear.
