import json
import boto3

s3Client = boto3.client('s3')
snsClient = boto3.client('sns')

def lambda_handler(event, context):
    # Log the event and context for debugging
    print(f"Received event: {json.dumps(event)}")
    print(f"Lambda function name: {context.function_name}")
    print(f"AWS Request ID: {context.aws_request_id}")
    
    # List all buckets in S3
    s3buckets = s3Client.list_buckets()
    buckets = s3buckets['Buckets']
    
    # Log each bucket name
    for bucket in buckets:
        print(f"Bucket Name: {bucket['Name']}")

    # Prepare the message with bucket names
    message = f"S3 Bucket List: {', '.join([bucket['Name'] for bucket in buckets])}"
    sns_topic_arn = "arn:aws:sns:us-east-2:565393024864:Ramesh-deomo1"

    # Send the message to SNS topic
    snsClient.publish(
        TopicArn=sns_topic_arn,
        Message=message,
        Subject="S3 Bucket List Notification"
    )

    return {
        'statusCode': 200,
        'body': json.dumps('S3 bucket list sent to SNS')
    }
