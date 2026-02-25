provider "aws"{
    region ="us-east-1"
}
variable "iam_policy_name" {
  description = "Name of the IAM policy"
  type        = string
  default     = "test_policy"  
}

variable "iam_role_name" {
  description = "Name of the IAM role"
  type        = string
   default     = "test_role"
}

data "template_file" "iam_policy" {
  template = file("${path.module}/iam_policy.tpl")
 # In Terraform, the ${path.module} interpolation is used to refer to the directory where the current Terraform configuration file 
# (usually .tf or .hcl) is located. It provides an absolute path to the directory containing the configuration file.
}

resource "aws_iam_policy" "iam_policy" {
  name        = var.iam_policy_name
  description = "Policy for ${var.iam_policy_name}"

  policy = data.template_file.iam_policy.rendered
}

resource "aws_iam_role" "iam_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  policy_arn = aws_iam_policy.iam_policy.arn
  role       = aws_iam_role.iam_role.name
}



# 