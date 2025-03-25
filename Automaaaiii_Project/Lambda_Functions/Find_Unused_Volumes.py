import boto3
import json

ec2_client = boto3.client('ec2')
sns_client = boto3.client('sns')

def lambda_handler(event, context):
    # SNS topic ARN for notification
    sns_topic_arn = "arn:aws:sns:us-east-2:123456789012:YourSNSTopic"  # Replace with your SNS ARN

    # List all volumes
    volumes = ec2_client.describe_volumes()
    
    # Check for unused volumes (volumes not attached to any instance)
    unused_volumes = []
    for volume in volumes['Volumes']:
        if len(volume['Attachments']) == 0:  # Volume is not attached to any instance
            unused_volumes.append(volume['VolumeId'])
    
    # If there are unused volumes, send an SNS notification
    if unused_volumes:
        # Create message
        message = f"Unused Volumes Detected: {', '.join(unused_volumes)}"
        
        # Send the SNS notification
        sns_client.publish(
            TopicArn=sns_topic_arn,
            Message=message,
            Subject="Unused EBS Volumes Notification"
        )
        return {
            'statusCode': 200,
            'body': json.dumps(f"Unused volumes found and notification sent: {', '.join(unused_volumes)}")
        }
    else:
        return {
            'statusCode': 200,
            'body': json.dumps("No unused volumes found.")
        }
