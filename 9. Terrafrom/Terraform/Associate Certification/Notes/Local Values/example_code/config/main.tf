provider "aws" {
    region = "us-east-1"
}
module "test" {
    source = "../module/"
    #ami = "a1234"
    instance_type = "t2.micro"
}

# the above code, if you uncomment -> ami = "a1234", it will give the following error becase you can't assign value to locals 

# Error: Unsupported argument

#   on main.tf line 6, in module "test":
#    6:     ami = "a1234"

# An argument named "ami" is not expected here.