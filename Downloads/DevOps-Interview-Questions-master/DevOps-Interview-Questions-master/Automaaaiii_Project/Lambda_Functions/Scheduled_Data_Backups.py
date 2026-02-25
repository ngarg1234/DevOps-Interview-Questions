import boto3

def lambda_handler(event, context):
    s3_client = boto3.client('s3')
    source_bucket = "source-bucket-name"
    destination_bucket = "destination-bucket-name"
    
    # List objects in the source bucket
    response = s3_client.list_objects_v2(Bucket=source_bucket)
    
    # Copy each file to the destination bucket
    if 'Contents' in response:
        for item in response['Contents']:
            file_key = item['Key']
            
            # Copy the object
            s3_client.copy_object(
                CopySource={'Bucket': source_bucket, 'Key': file_key},
                Bucket=destination_bucket,
                Key=file_key
            )
    
    return {
        'statusCode': 200,
        'body': "Backup completed successfully!"
    }
