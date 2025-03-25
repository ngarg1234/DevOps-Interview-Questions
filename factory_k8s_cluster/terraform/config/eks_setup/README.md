Accessing the eks cluster.

Add an iam role/user to aws-auth config.
If it's role -> attach the role to any ec2 instance.
If it's user, login to that user(aws configure) from any ec2 insatnce.
Install kubectl.
aws eks --region eu-west-1 update-kubeconfig --name <cluster-name>
 
