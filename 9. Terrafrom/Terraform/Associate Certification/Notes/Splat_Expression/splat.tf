resource "aws_iam_user" "lb"{
    count = 30
    name = "iamuser.${count.index}"
    path = "/users/"
}

output "arns" {
    value = aws_iam_user.lb[*].arn
}

## [*] is called splat expression, which helps to print the arn of all the 30 iam users created as part of resource "aws_iam_user" "lb


