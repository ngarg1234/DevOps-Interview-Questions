output "auth-config" {
    value = "${module.eks_setup.config_map_aws_auth}"
}
# this will be used inside the  jenkinsfile -> https://github.com/Shyamjith06/Pipelines/blob/main/pipeline_scripts/eks.groovy
#stage('Setting up the Cluster Access'
