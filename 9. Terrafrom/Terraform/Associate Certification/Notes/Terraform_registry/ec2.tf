module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.4.0"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

## this module already has default values set, so the script will create instance with the default values, if you need you can overcome those values
