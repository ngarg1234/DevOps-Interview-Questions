import boto3

s3_client = boto3.client('s3')

def lambda_handler(event, context):
    source_bucket = 'source-bucket-name'
    destination_bucket = 'destination-bucket-name'
    object_key = 'backup-object-key'

    # Copy the object from source to destination bucket
    copy_source = {'Bucket': source_bucket, 'Key': object_key}
    s3_client.copy_object(CopySource=copy_source, Bucket=destination_bucket, Key=object_key)

    return {
        'statusCode': 200,
        'body': f"Object {object_key} backed up from {source_bucket} to {destination_bucket}."
    }
