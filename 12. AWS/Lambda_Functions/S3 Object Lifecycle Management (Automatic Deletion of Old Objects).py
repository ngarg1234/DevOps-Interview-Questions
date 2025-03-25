import boto3
import time

s3_client = boto3.client('s3')

def lambda_handler(event, context):
    bucket_name = 'your-bucket-name'
    days_threshold = 30  # Delete objects older than 30 days
    current_time = time.time()

    # List all objects in the bucket
    response = s3_client.list_objects_v2(Bucket=bucket_name)

    for obj in response.get('Contents', []):
        last_modified = obj['LastModified'].timestamp()
        if (current_time - last_modified) > (days_threshold * 86400):
            # Delete object if older than the threshold
            s3_client.delete_object(Bucket=bucket_name, Key=obj['Key'])
            print(f"Deleted {obj['Key']}")

    return {
        'statusCode': 200,
        'body': "Old objects deleted successfully"
    }
