# Input variables
variable "size" {
  type    = string
  default = "t2.large"
}

# Local variables to compute derived values
locals {
  instance_name = "${terraform.workspace}-terraform"
}

variable "ami-id" {
    type = string
    default = "ami-0c55b159cbfafe1f0"
}


