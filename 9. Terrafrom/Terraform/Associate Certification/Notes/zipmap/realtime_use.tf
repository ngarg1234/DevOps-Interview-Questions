provider "aws" {
    region = "us-east-1"
}


resource "aws_iam_user" "lb" {
  count = 5
  name = "loadbalancer_${count.index}"
  path = "/system/"

  tags = {
    tag-key = "zipmap_test"
  }
}


output "users_arn" {
    value = zipmap(aws_iam_user.lb[*].name, aws_iam_user.lb[*].arn)
}

# output
# users_arn = {
#   "loadbalancer_0" = "arn:aws:iam::024705512663:user/system/loadbalancer_0"
#   "loadbalancer_1" = "arn:aws:iam::024705512663:user/system/loadbalancer_1"
#   "loadbalancer_2" = "arn:aws:iam::024705512663:user/system/loadbalancer_2"
#   "loadbalancer_3" = "arn:aws:iam::024705512663:user/system/loadbalancer_3"
#   "loadbalancer_4" = "arn:aws:iam::024705512663:user/system/loadbalancer_4"
# }