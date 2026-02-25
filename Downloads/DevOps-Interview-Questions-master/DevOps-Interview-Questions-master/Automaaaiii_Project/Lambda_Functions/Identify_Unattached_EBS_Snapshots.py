import boto3
import json

# Create boto3 clients for EC2 and SNS
ec2_client = boto3.client('ec2')
sns_client = boto3.client('sns')

def lambda_handler(event, context):
    # SNS topic ARN for notification
    sns_topic_arn = "arn:aws:sns:us-east-2:123456789012:YourSNSTopic"  # Replace with your SNS topic ARN

    # List all snapshots owned by the account
    snapshots_response = ec2_client.describe_snapshots(OwnerIds=['self'])
    snapshots = snapshots_response['Snapshots']

    # List all volumes (to check attachments)
    volumes_response = ec2_client.describe_volumes()
    attached_volume_ids = [volume['VolumeId'] for volume in volumes_response['Volumes']]

    # Identify unattached snapshots (snapshots not associated with any volume)
    unattached_snapshots = []
    for snapshot in snapshots:
        snapshot_volume_id = snapshot.get('VolumeId')
        if snapshot_volume_id and snapshot_volume_id not in attached_volume_ids:
            unattached_snapshots.append(snapshot['SnapshotId'])

    # If there are unattached snapshots, delete them and send an SNS notification
    if unattached_snapshots:
        # Delete unattached snapshots
        for snapshot_id in unattached_snapshots:
            print(f"Deleting snapshot {snapshot_id}")
            ec2_client.delete_snapshot(SnapshotId=snapshot_id)

        # Create a message with deleted snapshot details
        message = f"Unattached EBS Snapshots Deleted: {', '.join(unattached_snapshots)}"
        
        # Send the notification to the SNS topic
        sns_client.publish(
            TopicArn=sns_topic_arn,
            Message=message,
            Subject="Unattached EBS Snapshots Deletion Notification"
        )
        
        return {
            'statusCode': 200,
            'body': json.dumps(f"Unattached snapshots found, deleted, and notification sent: {', '.join(unattached_snapshots)}")
        }
    else:
        return {
            'statusCode': 200,
            'body': json.dumps("No unattached snapshots found.")
        }
