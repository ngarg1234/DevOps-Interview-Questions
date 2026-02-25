# send remote commands to director instance based on auto scaling group name
 
import json
import boto3
import os
import datetime
import logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)
 
def lambda_handler(event, context):
    logger.info(event)
    director_number = event['Payload']['director-number']
    github_id = event['Payload']['github-run-id']
    director_number = director_number[0]
    logger.info(director_number)
    asg_group_name = f'a201749-automai-director-{director_number}'
    logger.info(asg_group_name)
    client = boto3.client('autoscaling')
    response = client.describe_auto_scaling_groups(AutoScalingGroupNames=[asg_group_name])
    instance_ids = [i['InstanceId'] for i in response['AutoScalingGroups'][0]['Instances']]
    logger.info(instance_ids)
    date = datetime.datetime.now().strftime("%Y-%m-%d")
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d")
    director_name = 'director' + '-' + str(director_number)
    logs_path = 'C:\\Program Files\\Automai\\Director\\logs'
    logger.info(logs_path)
    logs_bucket_name = 's3://a201749-automai-director-logs' + '/' + timestamp + '/' + director_name + '/' + "logs" + '_' + github_id
    zip_bucket_name = 's3://a201749-automai-director-logs' + '/' + timestamp + '/' + director_name + '/' + "zip" + '_' + github_id
    logger.info(logs_bucket_name)
    ssm = boto3.client('ssm')
    for instance_id in instance_ids:
        log_response = ssm.send_command(
            InstanceIds=[instance_id],
            DocumentName="AWS-RunPowerShellScript",
            DocumentVersion="$LATEST",
            Parameters={
                'workingDirectory': ['C:\\Program Files\\Automai\\Director\\logs'],
                'commands': [
                    f'$currentDirectory = (Get-Location).Path',
                    f'Create-Item "C:\\logs" -type directory -force',
                    f'Compress-Archive -Path $currentDirectory -DestinationPath C:\\logs\\director-logs.zip',
                    f'aws s3 sync $currentDirectory {logs_bucket_name}'
                    f'aws s3 cp C:\\logs\\director-logs.zip {zip_bucket_name}\\director-logs.zip',
                ]
            }
            )
        print(log_response)
    return {
        'statusCode': 200,
        'body': json.dumps('Copied logs to S3 bucket!')
    }