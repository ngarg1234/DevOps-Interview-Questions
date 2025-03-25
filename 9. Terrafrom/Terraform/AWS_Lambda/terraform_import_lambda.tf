
# resource "aws_lambda_function" "terraform_import" {
#   function_name = "terraform_import_test"
#   handler       = "lambda_function.lambda_handler"
#   role          = "arn:aws:iam::155235525037:role/cfst-1449-4e974d177ddc8a95a69f76deeb6ef-LambdaRole-1FX1L8EZZLWDK"
#   s3_bucket = "terraform-im-test"
#   s3_key    = "lambda.zip"
#   runtime     = "python3.9"
# }