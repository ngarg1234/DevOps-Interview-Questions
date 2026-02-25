import boto3
import datetime
from dateutil.parser import parse as parse_date

def lambda_handler(event,context):
    ec2_client = boto3.client('ec2')
    amis=ec2_client.describe_images(
       Filters=[
           {
               'Name': 'tag:assetId',
               'Values': ['202990']
           }
       ]
    )
    threshold_date = datetime.datetime.now(datetime.timezone.utc) - datetime.timedelta(days=1)
    print(f"Threshold date for deletion: {threshold_date}")
   #print(amis['Images'])
    for x in amis['Images']:
       #print(x['ImageId'])
        creation_date = parse_date(x['CreationDate'])
        if creation_date < threshold_date:
            image_id = x['ImageId']
            print(f"Found AMI to delete: {image_id}, created on {creation_date}")

