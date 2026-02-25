provider "aws" {
    region ="us-east-1"
}

provider "aws" {
    alias = "dev_profile"
    region = "us-east-1"
    profile = "dev"  // you are specifying the profile here (profile needs to be set inside .aws/credentials )
}