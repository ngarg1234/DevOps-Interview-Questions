provider "aws" {
    region = "us-east-1"
}

resource "aws_lambda_function" "lambda_function_pas_troubleshooter_logs_signed_url" {
  function_name = "terraform-test-function"
  handler       = "lambda.lambda_handler"
  role          = "arn:aws:iam::321784826918:role/cfst-1449-4d5ccd8b8b219f34ac248db6206ab-LambdaRole-L9HBITFOYSA9"
  s3_bucket = "lambda-test-shyam"
  s3_key    = "Archive.zip"
  runtime     = "python3.9"
}