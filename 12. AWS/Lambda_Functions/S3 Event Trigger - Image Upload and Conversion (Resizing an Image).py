import json
import boto3
from PIL import Image
from io import BytesIO

s3_client = boto3.client('s3')

def lambda_handler(event, context):
    # Get the bucket and object key from the event
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    object_key = event['Records'][0]['s3']['object']['key']

    # Get the object from the bucket
    file_obj = s3_client.get_object(Bucket=bucket_name, Key=object_key)
    file_content = file_obj['Body'].read()

    # Resize the image
    image = Image.open(BytesIO(file_content))
    image = image.resize((800, 800))  # Resize to 800x800

    # Save the resized image to a new S3 location
    output_bucket = 'your-output-bucket'
    output_key = f"resized/{object_key}"

    buffer = BytesIO()
    image.save(buffer, 'PNG')
    buffer.seek(0)

    s3_client.put_object(Bucket=output_bucket, Key=output_key, Body=buffer)
    return {
        'statusCode': 200,
        'body': json.dumps(f"Image resized and saved to {output_key}")
    }
