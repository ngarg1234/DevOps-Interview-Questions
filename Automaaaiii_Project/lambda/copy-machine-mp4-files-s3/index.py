import json
import boto3
import os
import datetime
import logging
import time
logger = logging.getLogger()
logger.setLevel(logging.INFO)
 
def lambda_handler(event, context):
    logger.info(event)
    director_number = event['Payload']['director-number']
    director_number = director_number[0]
    logger.info(director_number)
    github_id = event['Payload']['github-run-id']
    asg_group_name = f'a201749-automai-botmanager-{director_number}'
    logger.info(asg_group_name)
    client = boto3.client('autoscaling')
    response = client.describe_auto_scaling_groups(AutoScalingGroupNames=[asg_group_name])
    instance_ids = [i['InstanceId'] for i in response['AutoScalingGroups'][0]['Instances']]
    logger.info(instance_ids)
    bot_manager_name = 'a201749-automai-botmanager' + '-' + str(director_number)
    try:
        ssm = boto3.client('ssm')
        for instance_id in instance_ids:
            date = datetime.datetime.now().strftime("%Y-%m-%d")
            def get_custom_tag(instance_id, tag_key):
                ec2 = boto3.client('ec2')  # Change this line
                response = ec2.describe_instances(InstanceIds=[instance_id])
                for reservation in response["Reservations"]:
                    for instance in reservation["Instances"]:
                        for tag in instance["Tags"]:
                            if tag["Key"] == tag_key:
                                return tag["Value"]    
                return None
            tag_key = 'hostname'
            hostname = get_custom_tag(instance_id, tag_key)
            logger.info(f'hostname: {hostname}')
            bot_manager_name = 'a201749-automai-botmanager-' + str(director_number)
            logger.info(f'bot_manager_name: {bot_manager_name}')
 
            for user_profile in range(1, 101):
                user_name = f"rLoader{user_profile:03d}"
                logger.info(f'user_name: {user_name}')
                user_number = f"{user_profile+1}"
                logger.info(f'user_number: {user_number}')
                mp4_video_bucket_name = 's3://a201749-automai-botmanager-logs/Video_Script_recordings' + '/' + str(date) + '/' + str(bot_manager_name) + '/' + str(hostname) + '/' + str(user_name) + '/'
                logger.info(f'mp4_video_bucket_name: {mp4_video_bucket_name}')
                mp4_video_path = f"C:\\Users\\{user_name}\\AppData\\Local\\Temp\\"
                logger.info(f'mp4_video_path: {mp4_video_path}')
                response = ssm.send_command(
                    InstanceIds=[instance_id],
                    DocumentName="AWS-RunPowerShellScript",
                    DocumentVersion="$LATEST",
                    Parameters={
                        'commands': [
                                f'if (Test-Path "{mp4_video_path}") {{ aws s3 sync {mp4_video_path} {mp4_video_bucket_name} }}',
                        ]
                    }
                )
                print(response)
                time.sleep(1)
                mp4_video_response = ssm.send_command(
                            InstanceIds=[instance_id],
                            DocumentName="AWS-RunPowerShellScript",
                            DocumentVersion="$LATEST",
                            Parameters={
                                    'commands': [
                                        f'aws s3 sync {mp4_video_path} {mp4_video_bucket_name}',
                                    ]
                            }
            )
            logger.info(mp4_video_response)
    except Exception as e:
        logger.error("Error occurred: ", exc_info=True)
    return {
        'statusCode': 200,
        'body': json.dumps('mp4 videos copied successfully!')
    }