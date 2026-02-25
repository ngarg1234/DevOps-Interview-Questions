# eks-terraform

Accesssing cluster



aws eks --region region update-kubeconfig --name cluster_name


aws eks --region eu-west-1 update-kubeconfig --name factory



infra set up

1, Create an EC2 instance in the eu-west-1 region and attach a role with admin access
    or create access and secret key then do an aws configure from the newly created ec2 instance
Create an aws key(for ec2 ssh) - devkey
##################################
----> Installing tools

execute tfenv script
execute awscli script 
execute kubectl script -> then run source ~/.bash_profile
##################################
----> Infra creation
create a terraform workspace - dev -> then terraform apply VPC script(terraform/config/eks_vpc)
create a terraform workspace - dev -> terraform apply k8s script 

