provider "aws" {
  region = "us-east-1"  # Change region as per your need
}

###############################
# Create Dead Letter Queue (DLQ)
###############################
resource "aws_sqs_queue" "dlq" {
  name                      = "my-dead-letter-queue"
  message_retention_seconds = 1209600  # 14 days

  # Enable encryption for DLQ
  kms_master_key_id         = "alias/aws/sqs"  # Default AWS managed key, can replace with custom KMS key
}

#######################################
# Main SQS Queue with Redrive to DLQ
#######################################
resource "aws_sqs_queue" "main_queue" {
  name                      = "my-main-queue"
  delay_seconds             = 0
  max_message_size          = 262144  # 256 KB
  message_retention_seconds = 345600  # 4 days
  visibility_timeout_seconds = 30
  receive_wait_time_seconds = 10  # Long polling for 10 seconds
  fifo_queue                = false  # Set to true for FIFO queues

  # Enable server-side encryption
  kms_master_key_id         = "alias/aws/sqs"  # Default AWS managed KMS key (replaceable)

  # Redrive policy to link DLQ
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 5  # After 5 failed receives, message moves to DLQ
  })

  tags = {
    Environment = "dev"
    Name        = "my-main-queue"
  }
}

#######################
# Output for reference
#######################
output "main_queue_url" {
  value = aws_sqs_queue.main_queue.id
}

output "main_queue_arn" {
  value = aws_sqs_queue.main_queue.arn
}

output "dlq_url" {
  value = aws_sqs_queue.dlq.id
}

output "dlq_arn" {
  value = aws_sqs_queue.dlq.arn
}




# Example output "Outputs:

# dlq_arn = "arn:aws:sqs:us-east-1:123456789012:my-dead-letter-queue"
# dlq_url = "https://sqs.us-east-1.amazonaws.com/123456789012/my-dead-letter-queue"
# main_queue_arn = "arn:aws:sqs:us-east-1:123456789012:my-main-queue"
# main_queue_url = "https://sqs.us-east-1.amazonaws.com/123456789012/my-main-queue"" {
  
}