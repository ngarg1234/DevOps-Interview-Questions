resource "aws_s3_bucket" "s3-vpc-flow-logs" {
  
  ### s3 bucket name doesn't allow _ so we are using replace function to replace _ with -
  #bucket = "${replace(terraform.workspace, "_", "-")}-vpc-flow-logs24"
  bucket = "eksfactory-vpc-flow-logs2"
  #region = "eu-west-1"

  lifecycle {
    prevent_destroy = false
  }

  lifecycle_rule {
    id      = "vpc-flow-logs-backups"
    enabled = true

    transition {
      days          = 180
      storage_class = "GLACIER"
    }
  }

  tags = {
    Name        = "eksfactory-vpc-flow-logs"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_s3_bucket_policy" "s3-vpc-flow-logs" {
    bucket = aws_s3_bucket.s3-vpc-flow-logs.id
    policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Id": "AWSLogDeliveryWrite20150319",
      "Statement": [
      {
      "Sid": "AWSLogDeliveryWrite",
      "Effect": "Allow",
      "Principal": {
      "Service": "delivery.logs.amazonaws.com"
      },
      "Condition": {
      "StringEquals": {
      "s3:x-amz-acl": "bucket-owner-full-control"
      }
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::eksfactory-vpc-flow-logs2/AWSLogs/499604764704/*"
      },
      {
      "Sid": "AWSLogDeliveryAclCheck",
      "Effect": "Allow",
      "Principal": {
      "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::eksfactory-vpc-flow-logs2"
      }
      ] 
      }
    )
    }
