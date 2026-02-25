module "vpc" {
  source          = "./modules/vpc"
  cidr_block      = var.vpc_cidr
  enable_dns_hostnames = true
}

module "ec2" {
  source      = "./modules/ec2"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.subnet_ids
  instance_type = var.instance_type
}

module "rds" {
  source       = "./modules/rds"
  db_subnet_ids = module.vpc.db_subnet_ids
  db_instance_class = var.db_instance_class
}

module "s3" {
  source = "./modules/s3"
  bucket_name = var.s3_bucket_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}
