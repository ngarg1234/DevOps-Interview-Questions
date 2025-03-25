import boto3
from PIL import Image
import io

def lambda_handler(event, context):
    s3_client = boto3.client('s3')
    
    # Extract bucket name and file key from the event
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    file_key = event['Records'][0]['s3']['object']['key']
    
    # Download the image from S3
    image_object = s3_client.get_object(Bucket=bucket_name, Key=file_key)
    image_data = image_object['Body'].read()
    
    # Open image using PIL (Python Imaging Library)
    image = Image.open(io.BytesIO(image_data))
    
    # Resize the image (you can change the size as per your requirements)
    image = image.resize((800, 800))
    
    # Save the resized image back to S3 in a different folder
    resized_key = f"resized/{file_key}"
    with io.BytesIO() as output:
        image.save(output, format='JPEG')
        output.seek(0)
        s3_client.put_object(Body=output, Bucket=bucket_name, Key=resized_key)
    
    return {
        'statusCode': 200,
        'body': f"Resized image uploaded to {resized_key}"
    }
