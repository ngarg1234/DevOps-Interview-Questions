variable "vpc_id" {
    type = string
}

variable "subnets" {
    type = list
}

variable "subnets_public" {
    type = list
}

variable "aws_region" {
    type = string
    default = "eu-west-1"
}
variable "cluster_name" {
    type = "string"
}

variable "key_name" {
    type = "string"
}


variable "k8s_version" {
  type    = "string"
  default = "1.17"
}

variable "node_ami" {
  type    = "string"
  default = "leap-eks-node-cis"
}


variable "node_ami_owner" {
  type    = "string"
  default = "228699574855"
}
variable "node_size" {
  type    = "string"
  default = "t2.medium"
}
variable "max_size" {
  type    = "string"
  default = 3
}

variable "min_size" {
  type    = "string"
  default = 1
}
