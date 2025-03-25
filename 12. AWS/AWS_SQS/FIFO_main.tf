provider "aws" {
  region = "us-east-1"  # Change to your region
}

###############################################
# Custom KMS Key for SQS Encryption (Optional)
###############################################
resource "aws_kms_key" "sqs_kms_key" {
  description             = "KMS key for encrypting SQS FIFO queues"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_kms_alias" "sqs_kms_alias" {
  name          = "alias/sqs-fifo-key"
  target_key_id = aws_kms_key.sqs_kms_key.key_id
}

#######################################
# Dead Letter FIFO Queue
#######################################
resource "aws_sqs_queue" "fifo_dlq" {
  name                      = "my-dead-letter-queue.fifo"
  fifo_queue                = true
  content_based_deduplication = true  # Optional, if no deduplication ID is provided
  message_retention_seconds = 1209600  # 14 days

  kms_master_key_id         = aws_kms_key.sqs_kms_key.arn  # Custom KMS key for encryption

  tags = {
    Environment = "dev"
    Purpose     = "DLQ"
  }
}

#######################################
# Main FIFO Queue with Redrive Policy
#######################################
resource "aws_sqs_queue" "fifo_main_queue" {
  name                      = "my-main-queue.fifo"
  fifo_queue                = true
  content_based_deduplication = true  # Optional, set to false if using MessageDeduplicationId
  delay_seconds             = 0
  max_message_size          = 262144  # 256 KB
  message_retention_seconds = 345600  # 4 days
  visibility_timeout_seconds = 45
  receive_wait_time_seconds = 10  # Long polling to reduce costs and latency

  # Enable encryption with custom KMS key
  kms_master_key_id         = aws_kms_key.sqs_kms_key.arn

  # Redrive policy to link to DLQ
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.fifo_dlq.arn
    maxReceiveCount     = 3  # After 3 failed processing attempts, move to DLQ
  })

  tags = {
    Environment = "dev"
    Purpose     = "Main FIFO Queue"
  }
}

#######################
# Output Values
#######################
output "fifo_main_queue_url" {
  value = aws_sqs_queue.fifo_main_queue.id
}

output "fifo_main_queue_arn" {
  value = aws_sqs_queue.fifo_main_queue.arn
}

output "fifo_dlq_url" {
  value = aws_sqs_queue.fifo_dlq.id
}

output "fifo_dlq_arn" {
  value = aws_sqs_queue.fifo_dlq.arn
}

output "kms_key_arn" {
  value = aws_kms_key.sqs_kms_key.arn
}
