
variable "aws_account_id" {
  type = map(string)

  default = {
    cyclones-load      = "670689373697"
    cyclones-dev       = "499604764704"
    cyclones-ppe       = "394333930054"
    cyclones-prod      = "305366777960"
    cyclones-sit       = "693793123069"
    cyclones-uat       = "755264997877"
    cyclones-test_mgmt = "453130194223"
    cyclones-prod-mgmt = "189539755066"
  }
}
locals {
 all_root_account_arns_errored_one = [
     formatlist("arn:aws:iam::%s:root", values(var.aws_account_id)),
 ]
 all_root_account_arns_corrected_one =flatten(formatlist("arn:aws:iam::%s:root", values(var.aws_account_id)),)
  
all_root_account_arns_corrected_one2 =formatlist("arn:aws:iam::%s:root", values(var.aws_account_id))
}

  #resources = [for u in var.usernames : "arn:aws:rds-db:us-east-1:${var.account_id}:dbuser:${aws_db_instance.name.resource_id}/${u}"]
